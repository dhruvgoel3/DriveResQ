import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/Mechanic_logics/mechanic_homescreen_viewmodel.dart';

class MechanicHomeModule extends StatelessWidget {
  final controller = Get.put(MechanicHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby SOS Requests')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.nearbyRequests.isEmpty) {
          return Center(child: Text("No nearby requests"));
        }
        return ListView.builder(
          itemCount: controller.nearbyRequests.length,
          itemBuilder: (context, index) {
            final request = controller.nearbyRequests[index];
            return Card(
              margin: EdgeInsets.all(12),
              child: ListTile(
                title: Text("Vehicle: ${request['vehicle_type']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Problem: ${request['description']}"),
                    Text("Area: ${request['area']}"),
                    Text("Location: ${request['location']}"),
                    Text("Distance: ${request['distance']} km"),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        );
      }),
    );
  }
}
