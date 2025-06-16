import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:provider/provider.dart';

class TomatoIcons extends StatelessWidget {
  final double tomatoIconSize;
  const TomatoIcons({super.key, required this.tomatoIconSize});

  @override
  Widget build(BuildContext context) {
    final timerService = Provider.of<TimerService>(context);
    List<Widget> tomatoes = [];
    int filledTomatoes = timerService.isLongBreakTime ? 4 : timerService.sessionCount % 4;

    for (int i = 0; i < 4; i++) {
      if (i < filledTomatoes) {
        tomatoes.add(SvgPicture.asset('assets/icons/filled_tomato.svg', width: tomatoIconSize, height: tomatoIconSize));
      } else {
        tomatoes.add(SvgPicture.asset('assets/icons/empty_tomato.svg', width: tomatoIconSize, height: tomatoIconSize));
      }
      tomatoes.add(SizedBox(width: 5));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tomatoes,
    );
  }
}
