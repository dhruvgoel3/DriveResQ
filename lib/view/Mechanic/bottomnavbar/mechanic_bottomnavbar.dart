import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:driveresq/view/Mechanic/Chat/mechanic_chat_module.dart';
import 'package:driveresq/view/Mechanic/History/mechanic_history_screen_module.dart';
import 'package:driveresq/view/Mechanic/Home/mechanic_home_module.dart';
import 'package:driveresq/view/Mechanic/Profile/profile_module.dart';
import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MechanicBottomnavbar extends StatefulWidget {
  @override
  _FloatingNavBarAppState createState() => _FloatingNavBarAppState();
}

class _FloatingNavBarAppState extends State<MechanicBottomnavbar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MechanicHomeModule(),
    MechanicHistoryScreenModule(),
    MechanicChatScreenModule(),
    MechanicProfileModule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Shows body behind nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: AppColors.NavBarBackColor,
        selectedItemColor: AppColors.DarkCamel,
        unselectedItemColor: Colors.grey,
        selectedBackgroundColor: Colors.deepPurple.withOpacity(0.1),
        margin: EdgeInsets.symmetric(),

        borderRadius: 20,
        padding: EdgeInsets.symmetric(horizontal: 10),

        onTap: (int val) => setState(() => _selectedIndex = val),
        currentIndex: _selectedIndex,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.history_sharp, title: 'History'),
          FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
          FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
        ],
      ),
    );
  }
}
