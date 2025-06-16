import 'package:flutter/material.dart';
import 'package:pomodoro_timer/animations/base_session_animation.dart';

class WorkingTimeAnimation extends StatelessWidget {
  final double width;
  final double height;
  final bool isRunning;
  final String themeName;

  const WorkingTimeAnimation({
    super.key,
    required this.width,
    required this.height,
    required this.isRunning,
    required this.themeName,
  });

  @override
  Widget build(BuildContext context) {
    return BaseSessionAnimation(
        width: width,
        height: height,
        isRunning: isRunning,
        themeName: themeName,
        sessionType: 'working'
    );
  }
}
