// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:geocoding/geocoding.dart';
//
// class HelpRequest {
//   String area;
//   String vehicleType;
//   String problem;
//   String location;
//   String status;
//   double? lat;
//   double? lng;
//
//   HelpRequest({
//     required this.area,
//     required this.vehicleType,
//     required this.problem,
//     required this.location,
//     this.status = 'draft',
//     this.lat,
//     this.lng,
//   });
// }
//
// class DriverDashboardController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final helpRequests = <HelpRequest>[].obs;
//
//   final areaController = TextEditingController();
//   final problemController = TextEditingController();
//   final locationController = TextEditingController();
//   final selectedType = ''.obs;
//   final vehicleTypes = ['Car', 'Bike', 'Truck'];
//
//   Future<String> getAddressFromLatLng(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       final place = placemarks.first;
//       return "${place.name}, ${place.locality}, ${place.administrativeArea}";
//     } catch (e) {
//       return "Unknown location";
//     }
//   }
//
//   void openHelpDialog() async {
//     areaController.clear();
//     problemController.clear();
//     locationController.clear();
//     selectedType.value = '';
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       await Geolocator.requestPermission();
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//
//     String readableLocation = await getAddressFromLatLng(
//       position.latitude,
//       position.longitude,
//     );
//
//     locationController.text = readableLocation;
//
//     Get.dialog(_buildDialog(position));
//   }
//
//   Widget _buildDialog(Position position) {
//     return AlertDialog(
//       title: Text("Create Help Request"),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: areaController,
//               decoration: InputDecoration(labelText: "Nearby Area"),
//             ),
//             SizedBox(height: 8),
//             DropdownButton<String>(
//               hint: Text("Select Vehicle Type"),
//               isExpanded: true,
//               value: selectedType.value.isEmpty ? null : selectedType.value,
//               items: vehicleTypes
//                   .map((v) => DropdownMenuItem(value: v, child: Text(v)))
//                   .toList(),
//               onChanged: (val) => selectedType.value = val ?? '',
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: problemController,
//               decoration: InputDecoration(labelText: "Vehicle Problem"),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: locationController,
//               decoration: InputDecoration(
//                 labelText: "Location (manual or GPS)",
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
//         ElevatedButton(
//           onPressed: () => saveHelpRequest(position),
//           child: Text("Save"),
//         ),
//       ],
//     );
//   }
//
//   void saveHelpRequest(Position position) {
//     if (areaController.text.isEmpty ||
//         selectedType.value.isEmpty ||
//         problemController.text.isEmpty ||
//         locationController.text.isEmpty) {
//       Get.snackbar("Missing Info", "Please fill all fields");
//       return;
//     }
//
//     final request = HelpRequest(
//       area: areaController.text,
//       vehicleType: selectedType.value,
//       problem: problemController.text,
//       location: locationController.text,
//       lat: position.latitude,
//       lng: position.longitude,
//     );
//
//     helpRequests.add(request);
//     Get.back();
//   }
//
//   Future<void> sendSOS(HelpRequest request) async {
//     try {
//       final user = Supabase.instance.client.auth.currentUser;
//       if (user == null) {
//         Get.snackbar("Login Required", "You must login first");
//         return;
//       }
//
//       // Debugging logs
//       print("USER ID: ${user.id}");
//       print("USER EMAIL: ${user.email}");
//
//       await Supabase.instance.client.from('requests').insert({
//         'driver_id': user.id, // ✅ UUID
//         'driver_name': user.id, // ✅ email
//         'vehicle_type': request.vehicleType,
//         'description': request.problem,
//         'location': request.location,
//         'status': 'pending',
//         'area': request.area,
//         'lat': request.lat,
//         'lng': request.lng,
//       });
//
//       Get.snackbar("SOS Sent", "Mechanics will be notified");
//       helpRequests.remove(request);
//     } catch (e) {
//       Get.snackbar("Error", "Failed to send request: $e");
//       print("SEND SOS ERROR: $e");
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geocoding/geocoding.dart';

class DriverDashboardController extends GetxController {
  final supabase = Supabase.instance.client;

  final areaController = TextEditingController();
  final locationController = TextEditingController();
  final problemController = TextEditingController();
  final vehicleTypes = ['Car', 'Bike', 'Truck'];
  final selectedType = ''.obs;

  final isLoading = false.obs;
  final helpRequests = [].obs;

  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    _checkAuthAndLoad();
  }

  Future<void> _checkAuthAndLoad() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      Get.snackbar("Unauthorized", "You must login");
      Get.offAllNamed('/login'); // redirect to login
      return;
    }
    await fetchHelpRequests();
  }

  Future<void> fetchHelpRequests() async {
    isLoading.value = true;
    try {
      final user = supabase.auth.currentUser!;
      final data = await supabase
          .from('requests')
          .select()
          .eq('driver_id', user.id)
          .order('created_at', ascending: false);

      helpRequests.value = data;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch requests: $e");
    } finally {
      isLoading.value = false;
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

    currentPosition = await Geolocator.getCurrentPosition();
    locationController.text = await _getAddressFromLatLng(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );

    Get.dialog(_buildHelpDialog());
  }

  Widget _buildHelpDialog() {
    return AlertDialog(
      title: Text("Request Help"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: areaController, decoration: InputDecoration(labelText: "Area")),
          SizedBox(height: 10),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedType.value.isEmpty ? null : selectedType.value,
            hint: Text("Select Vehicle Type"),
            items: vehicleTypes
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (val) => selectedType.value = val ?? '',
          ),
          SizedBox(height: 10),
          TextField(controller: locationController, decoration: InputDecoration(labelText: "Location")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
        ElevatedButton(onPressed: saveRequestToDrafts, child: Text("Save")),
      ],
    );
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      final place = placemarks.first;
      return "${place.name}, ${place.locality}, ${place.administrativeArea}";
    } catch (e) {
      return "Unknown";
    }
  }

  void saveRequestToDrafts() async {
    final user = supabase.auth.currentUser!;
    if (areaController.text.isEmpty || selectedType.value.isEmpty || locationController.text.isEmpty) {
      Get.snackbar("Missing", "All fields are required");
      return;
    }

    final request = {
      'driver_id': user.id,
      'driver_name': user.email,
      'area': areaController.text,
      'vehicle_type': selectedType.value,
      'location': locationController.text,
      'description': "Waiting to send SOS",
      'status': 'draft',
      'lat': currentPosition?.latitude,
      'lng': currentPosition?.longitude,
    };

    try {
      await supabase.from('requests').insert(request);
      Get.back();
      fetchHelpRequests();
      Get.snackbar("Saved", "Help request saved");
    } catch (e) {
      Get.snackbar("Error", "Failed to save: $e");
    }
  }

  void sendSOS(int requestId) async {
    try {
      await supabase.from('requests').update({'status': 'pending'}).eq('id', requestId);
      fetchHelpRequests();
      Get.snackbar("SOS Sent", "Mechanics will see your request");
    } catch (e) {
      Get.snackbar("Error", "Failed to send SOS: $e");
    }
  }
}
