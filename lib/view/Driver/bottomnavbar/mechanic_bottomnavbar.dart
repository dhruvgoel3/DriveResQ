import 'package:driveresq/view/Driver/Home/driver_homesreen_module.dart';
import 'package:driveresq/view/Driver/chat/driver_chatscreen_module.dart';
import 'package:driveresq/view/Driver/helpinfo/driver_helpinfo_module.dart';
import 'package:driveresq/view/Driver/profile/driver_profile_screen_module.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class DriverBottomNavBar extends StatefulWidget {
  const DriverBottomNavBar({super.key});

  @override
  State<DriverBottomNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DriverBottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> tabItems = [
  DriverDashboardScreen(),
    DriverHelpInfoModule(),
    DriverChatScreenModule(),
    DriverProfileScreenModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabItems[selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() => selectedIndex = index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.chat),
            title: const Text('Chat'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text('Alerts'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
