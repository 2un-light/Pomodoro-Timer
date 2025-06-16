import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';
import 'package:pomodoro_timer/service/modal_service.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:provider/provider.dart';

Widget timerControlButtons(BuildContext context, double timerControlButtonIconSize) {
  final timerService = Provider.of<TimerService>(context);
  final modalService = Provider.of<ModalService>(context);
  final themeService = Provider.of<ThemeService>(context);
  AppTheme selectedTheme = themeService.currentTheme;

  if (timerService.isTimerRunning) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => timerService.pauseTimer(),
          child: SvgPicture.asset('assets/icons/pause.svg', width: timerControlButtonIconSize, height: timerControlButtonIconSize, color: selectedTheme.focusColor,),
        )
      ],
    );
  } else if (timerService.isTimerPaused) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => timerService.resumeTimer(),
          child: SvgPicture.asset('assets/icons/play_arrow.svg', width: timerControlButtonIconSize, height: timerControlButtonIconSize, color: selectedTheme.shortBreakColor,),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () => modalService.showCustomDialog(
              context: context,
              title: "⏰ 타이머 재시작",
              message: "타이머를 다시 시작하면 진행 중인 시간이 초기화돼요.\n계속할까요?",
              showCancelButton: true,
              confirmText: "네",
              cancelText: "아니요",
              onConfirm: () => timerService.restartTimer()),
          child: SvgPicture.asset('assets/icons/replay.svg', width: timerControlButtonIconSize, height: timerControlButtonIconSize, color: selectedTheme.longBreakColor,),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () => modalService.showCustomDialog(
              context: context,
              title: "🌙 모든 세션 종료",
              message: "지금 세션을 종료하면 진행 중인 타이머가 중단돼요.\n계속할까요?",
              showCancelButton: true,
              confirmText: "네",
              cancelText: "아니요",
              onConfirm: () => timerService.cancelTimer()),
          child: SvgPicture.asset('assets/icons/cancel.svg', width: timerControlButtonIconSize, height: timerControlButtonIconSize, color: selectedTheme.focusColor,),
        )
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => timerService.startTimer(),
          child: SvgPicture.asset('assets/icons/play_arrow.svg', width: timerControlButtonIconSize, height: timerControlButtonIconSize, color: selectedTheme.shortBreakColor,),
        ),
      ],
    );
  }
}