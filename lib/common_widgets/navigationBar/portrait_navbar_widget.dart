import 'package:flutter/material.dart';
import 'package:pomodoro_timer/enums/navigation_bar_page.dart';
import 'package:pomodoro_timer/screens/home/home_screen.dart';
import 'package:pomodoro_timer/screens/settings/settings_screen.dart';
import 'package:pomodoro_timer/common_widgets/navigationBar/build_navigation_icon_widget.dart';

class PortraitNavbar extends StatelessWidget {
  final double iconSize;
  final double horizontalMargin;
  final NavBarPage currentPage;

  const PortraitNavbar({
    super.key,
    required this.iconSize,
    required this.horizontalMargin,
    required this.currentPage,
  });

  void _navigate(BuildContext context, NavBarPage targetPage) {
    if(targetPage == currentPage) return;

    final screen = targetPage == NavBarPage.home ? HomeScreen() : SettingsScreen();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _navigate(context, NavBarPage.home),
            child: BuildNavIcon(iconName: 'timer', size: iconSize),
          ),
          GestureDetector(
            onTap: () => _navigate(context, NavBarPage.settings),
            child: BuildNavIcon(iconName: 'settings', size: iconSize),
          )
        ],
      ),
    );
  }
}
