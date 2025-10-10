import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HelpRequestDialog extends StatefulWidget {
  final Function({
  required String area,
  required String vehicleType,
  required String location,
  required double latitude,
  required double longitude,
  }) onSave;

  const HelpRequestDialog({super.key, required this.onSave});

  @override
  State<HelpRequestDialog> createState() => _HelpRequestDialogState();
}

class _HelpRequestDialogState extends State<HelpRequestDialog> {
  final areaController = TextEditingController();
  final locationController = TextEditingController();
  final vehicleTypes = ['Car', 'Bike', 'Truck'];
  String selectedType = '';
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    currentPosition = await Geolocator.getCurrentPosition();
    locationController.text = await _getAddressFromLatLng(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );

    setState(() {}); // Rebuild after getting location
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

  void _handleSave() {
    if (areaController.text.isEmpty || selectedType.isEmpty || locationController.text.isEmpty) {
      Get.snackbar("Missing Info", "Please fill all fields");
      return;
    }

    if (currentPosition == null) {
      Get.snackbar("Location Error", "Failed to get current position");
      return;
    }

    widget.onSave(
      area: areaController.text,
      vehicleType: selectedType,
      location: locationController.text,
      latitude: currentPosition!.latitude,
      longitude: currentPosition!.longitude,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Request Help"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: areaController, decoration: const InputDecoration(labelText: "Area")),
          const SizedBox(height: 10),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedType.isEmpty ? null : selectedType,
            hint: const Text("Select Vehicle Type"),
            items: vehicleTypes.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (val) => setState(() => selectedType = val ?? ''),
          ),
          const SizedBox(height: 10),
          TextField(controller: locationController, decoration: const InputDecoration(labelText: "Location")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
        ElevatedButton(onPressed: _handleSave, child: const Text("Save")),
      ],
    );
  }
}
