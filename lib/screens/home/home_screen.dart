import 'package:flutter/material.dart';
import 'package:pomodoro_timer/service/permission_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:provider/provider.dart';
import 'home_landscape_screen.dart';
import 'home_portrait_screen.dart';

class HomeScreen extends StatefulWidget {
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  final _permissionService = PermissionService();
  @override
  void initState() {
    super.initState();
    _permissionService.requestNotificationPermissionIfNeeded();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TimerService>(
      builder: (context, timerService, child) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return HomePortraitScreen();
              } else {
                return HomeLandscapeScreen();
              }
            },
          ),
        );
      },
    );
  }
}