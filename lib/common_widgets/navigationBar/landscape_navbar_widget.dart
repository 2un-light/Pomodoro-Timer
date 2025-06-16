import 'package:flutter/material.dart';
import 'package:pomodoro_timer/enums/navigation_bar_page.dart';
import 'package:pomodoro_timer/screens/home/home_screen.dart';
import 'package:pomodoro_timer/screens/settings/settings_screen.dart';
import 'package:pomodoro_timer/common_widgets/navigationBar/build_navigation_icon_widget.dart';
import 'package:pomodoro_timer/screens/home/widgets/timer_control_buttons_widget.dart';

class LandscapeNavBar extends StatelessWidget {
  final double iconSize;
  final double timerControlButtonIconSize;
  final double horizonalMargin;
  final NavBarPage currentPage;

  const LandscapeNavBar({
    super.key,
    required this.iconSize,
    required this.timerControlButtonIconSize,
    required this.horizonalMargin,
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
      margin: EdgeInsets.symmetric(horizontal: horizonalMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _navigate(context, NavBarPage.home),
            child: BuildNavIcon(iconName: 'timer', size: iconSize),
          ),
          timerControlButtons(context, timerControlButtonIconSize),
          GestureDetector(
            onTap: () => _navigate(context, NavBarPage.settings),
            child: BuildNavIcon(iconName: 'settings', size: iconSize),
          ),
        ],
      ),
    );
  }
}
