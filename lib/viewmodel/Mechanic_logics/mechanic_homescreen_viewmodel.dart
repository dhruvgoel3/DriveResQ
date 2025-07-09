import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

class MechanicHomeController extends GetxController {
  final supabase = Supabase.instance.client;
  final nearbyRequests = [].obs;
  final isLoading = false.obs;

  double mechanicLat = 0.0;
  double mechanicLng = 0.0;

  @override
  void onInit() {
    super.onInit();
    fetchLocationAndRequests();
  }

  Future<void> fetchLocationAndRequests() async {
    isLoading.value = true;
    try {
      // ✅ Step 1: Get current mechanic location
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      mechanicLat = pos.latitude;
      mechanicLng = pos.longitude;

      // ✅ Step 2: Get requests from Supabase
      final response = await supabase
          .from('requests')
          .select()
          .eq('status', 'pending');

      // ✅ Step 3: Filter by distance
      List filtered = [];
      for (var req in response) {
        if (req['lat'] != null && req['lng'] != null) {
          double distance = calculateDistance(
            mechanicLat,
            mechanicLng,
            req['lat'],
            req['lng'],
          );
          if (distance <= 10.0) {
            req['distance'] = distance.toStringAsFixed(2);
            filtered.add(req);
          }
        }
      }

      nearbyRequests.value = filtered;
    } catch (e) {
      Get.snackbar("Error", "Failed to load requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    const p = 0.0174533;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) *
            cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) /
            2;
    return 12742 * asin(sqrt(a)); // in km
  }
}
