// ✅ MECHANIC HOME CONTROLLER

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
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
    fetchNearbyRequests();
  }

  Future<void> fetchNearbyRequests() async {
    isLoading.value = true;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }

      Position pos = await Geolocator.getCurrentPosition();
      mechanicLat = pos.latitude;
      mechanicLng = pos.longitude;

      final List<dynamic> response = await supabase
          .from('requests')
          .select()
          .eq('status', 'pending');

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

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.0174533;
    final a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
