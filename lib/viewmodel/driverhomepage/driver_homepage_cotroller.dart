import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geocoding/geocoding.dart';

class HelpRequest {
  String area;
  String vehicleType;
  String problem;
  String location;
  String status;
  double? lat;
  double? lng;

  HelpRequest({
    required this.area,
    required this.vehicleType,
    required this.problem,
    required this.location,
    this.status = 'draft',
    this.lat,
    this.lng,
  });
}

class DriverDashboardController extends GetxController {
  final supabase = Supabase.instance.client;
  final helpRequests = <HelpRequest>[].obs;

  final areaController = TextEditingController();
  final problemController = TextEditingController();
  final locationController = TextEditingController();
  final selectedType = ''.obs;
  final vehicleTypes = ['Car', 'Bike', 'Truck'];

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      final place = placemarks.first;
      return "${place.name}, ${place.locality}, ${place.administrativeArea}";
    } catch (e) {
      return "Unknown location";
    }
  }

  void openHelpDialog() async {
    areaController.clear();
    problemController.clear();
    locationController.clear();
    selectedType.value = '';

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    String readableLocation = await getAddressFromLatLng(
      position.latitude,
      position.longitude,
    );

    locationController.text = readableLocation;

    Get.dialog(_buildDialog(position));
  }

  Widget _buildDialog(Position position) {
    return AlertDialog(
      title: Text("Create Help Request"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: areaController,
              decoration: InputDecoration(labelText: "Nearby Area"),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              hint: Text("Select Vehicle Type"),
              isExpanded: true,
              value: selectedType.value.isEmpty ? null : selectedType.value,
              items: vehicleTypes
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (val) => selectedType.value = val ?? '',
            ),
            SizedBox(height: 8),
            TextField(
              controller: problemController,
              decoration: InputDecoration(labelText: "Vehicle Problem"),
            ),
            SizedBox(height: 8),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "Location (manual or GPS)",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
        ElevatedButton(
          onPressed: () => saveHelpRequest(position),
          child: Text("Save"),
        ),
      ],
    );
  }

  void saveHelpRequest(Position position) {
    if (areaController.text.isEmpty ||
        selectedType.value.isEmpty ||
        problemController.text.isEmpty ||
        locationController.text.isEmpty) {
      Get.snackbar("Missing Info", "Please fill all fields");
      return;
    }

    final request = HelpRequest(
      area: areaController.text,
      vehicleType: selectedType.value,
      problem: problemController.text,
      location: locationController.text,
      lat: position.latitude,
      lng: position.longitude,
    );

    helpRequests.add(request);
    Get.back();
  }

  Future<void> sendSOS(HelpRequest request) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        Get.snackbar("Login Required", "You must login first");
        return;
      }

      print("Sending SOS with lat: ${request.lat}, lng: ${request.lng}");

      await supabase.from('requests').insert({
        'driver_id': user.id, //  this is a valid UUID
        'driver_name': user.email, // keep this for name/email
        'vehicle_type': request.vehicleType,
        'description': request.problem,
        'location': request.location,
        'status': 'pending',
        'area': request.area,
        'lat': request.lat,
        'lng': request.lng,
      });

      Get.snackbar("SOS Sent", "Mechanics will be notified");
      helpRequests.remove(request);
    } catch (e) {
      Get.snackbar("Error", "Failed to send request: $e");
    }
  }
}
