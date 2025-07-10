import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:driveresq/view/Driver/Home/driver_homesreen_module.dart';
import 'package:driveresq/view/Driver/chat/driver_chatscreen_module.dart';
import 'package:driveresq/view/Driver/helpinfo/driver_helpinfo_module.dart';
import 'package:driveresq/view/Driver/profile/driver_profile_screen_module.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

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
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 450),
        iconSize: 25,
        backgroundColor: AppColors.NavBarBackColor,
        selectedIndex: selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() => selectedIndex = index),
        items: [
          FlashyTabBarItem(
            icon: LineIcon(CupertinoIcons.home, color: AppColors.DarkCamel),
            title: Text(
              'DashBoard',
              style: GoogleFonts.poppins(
                color: AppColors.BubbleGrey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: LineIcon(
              CupertinoIcons.location_solid,
              color: AppColors.DarkCamel,
            ),
            title: Text(
              'Location',
              style: GoogleFonts.poppins(
                color: AppColors.BubbleGrey,

                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: LineIcon(
              CupertinoIcons.chat_bubble_text_fill,
              color: AppColors.DarkCamel,
            ),
            title: Text(
              'Chats',
              style: GoogleFonts.poppins(
                color: AppColors.BubbleGrey,

                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: LineIcon(CupertinoIcons.person, color: AppColors.DarkCamel),
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(
                color: AppColors.BubbleGrey,

                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
