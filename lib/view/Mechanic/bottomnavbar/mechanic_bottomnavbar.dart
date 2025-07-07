import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class MechanicBottomnavbar extends StatefulWidget {
  @override
  _FloatingNavBarAppState createState() => _FloatingNavBarAppState();
}

class _FloatingNavBarAppState extends State<MechanicBottomnavbar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Shows body behind nav bar
      body: _screens[_selectedIndex],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        selectedBackgroundColor: Colors.deepPurple.withOpacity(0.1),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
