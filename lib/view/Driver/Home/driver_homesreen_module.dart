// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../viewmodel/driverhomepage/driver_homepage_cotroller.dart';
//
// class DriverDashboardScreen extends StatelessWidget {
//   final controller = Get.put(DriverDashboardController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Driver Dashboard")),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: controller.openHelpDialog,
//         label: Text("Request Help"),
//         icon: Icon(Icons.add_alert),
//       ),
//       body: Obx(() {
//         if (controller.helpRequests.isEmpty) {
//           return Center(child: Text("No help requests created yet"));
//         }
//
//         return ListView.builder(
//           itemCount: controller.helpRequests.length,
//           itemBuilder: (context, index) {
//             final req = controller.helpRequests[index];
//             return Card(
//               margin: EdgeInsets.all(12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ListTile(
//                 title: Text("🆘 ${req.problem}"),
//                 subtitle: Text(
//                   "Area: ${req.area}\nVehicle: ${req.vehicleType}\nLocation: ${req.location}",
//                 ),
//                 trailing: ElevatedButton(
//                   onPressed: () => controller.sendSOS(req),
//                   child: Text("Send SOS"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodel/driverhomepage/driver_homepage_cotroller.dart';

class DriverDashboardScreen extends StatelessWidget {
  final controller = Get.put(DriverDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Dashboard")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.helpRequests.isEmpty) {
          return Center(child: Text("No help requests found"));
        }

        return ListView.builder(
          itemCount: controller.helpRequests.length,
          itemBuilder: (context, index) {
            final item = controller.helpRequests[index];
            return Card(
              margin: EdgeInsets.all(12),
              child: ListTile(
                title: Text("Area: ${item['area']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vehicle: ${item['vehicle_type']}"),
                    Text("Location: ${item['location']}"),
                    Text("Status: ${item['status']}"),
                  ],
                ),
                trailing: item['status'] == 'draft'
                    ? ElevatedButton(
                  onPressed: () => controller.sendSOS(item['id']),
                  child: Text("Send SOS"),
                )
                    : null,
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.openHelpDialog,
        icon: Icon(Icons.help),
        label: Text("Request Help"),
      ),
    );
  }
}
