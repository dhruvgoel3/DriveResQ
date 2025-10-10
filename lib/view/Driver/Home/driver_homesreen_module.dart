import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/driverhomepage/driver_homepage_cotroller.dart';
import 'open_aleart_box.dart';

class DriverDashboardScreen extends StatelessWidget {
  final controller = Get.put(RequestController());

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
        onPressed: (){
          Get.to(()=>HelpRequestDialog);
          showDialog(context: context, builder: ()=>HelpRequestDialog());
        },
        icon: Icon(Icons.help),
        label: Text("Request Help"),
      ),
    );
  }
}
