import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodel/driverhomepage/driver_homepage_cotroller.dart';

class DriverDashboardScreen extends StatelessWidget {
  final controller = Get.put(DriverDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Dashboard")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openHelpDialog,
        label: Text("Request Help"),
        icon: Icon(Icons.add_alert),
      ),
      body: Obx(() {
        if (controller.helpRequests.isEmpty) {
          return Center(child: Text("No help requests created yet"));
        }

        return ListView.builder(
          itemCount: controller.helpRequests.length,
          itemBuilder: (context, index) {
            final req = controller.helpRequests[index];
            return Card(
              margin: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text("🆘 ${req.problem}"),
                subtitle: Text(
                  "Area: ${req.area}\nVehicle: ${req.vehicleType}\nLocation: ${req.location}",
                ),
                trailing: ElevatedButton(
                  onPressed: () => controller.sendSOS(req),
                  child: Text("Send SOS"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
