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
    fetchLocationAndRequests();
  }

  Future<void> fetchLocationAndRequests() async {
    isLoading.value = true;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        await Geolocator.requestPermission();
      }

      Position pos = await Geolocator.getCurrentPosition();
      mechanicLat = pos.latitude;
      mechanicLng = pos.longitude;

      print("Mechanic location: $mechanicLat, $mechanicLng");

      final response = await supabase
          .from('requests')
          .select()
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      List filtered = [];
      for (var req in response) {
        print("Request at: ${req['lat']}, ${req['lng']}");

        if (req['lat'] != null && req['lng'] != null) {
          double distance = calculateDistance(
            mechanicLat,
            mechanicLng,
            req['lat'],
            req['lng'],
          );
          print("Calculated distance: $distance km");

          // 🚨 TEMPORARY: include all requests for testing
          // Remove condition after testing
          // if (distance <= 10.0) {
          req['distance'] = distance.toStringAsFixed(2);
          filtered.add(req);
          // }
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
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
