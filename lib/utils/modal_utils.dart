import 'package:flutter/cupertino.dart';
import 'package:pomodoro_timer/enums/timer_alert_type.dart';
import 'package:pomodoro_timer/service/modal_service.dart';
import 'package:provider/provider.dart';

class ModalUtils {
  static final ModalUtils _instance = ModalUtils._internal();

  factory ModalUtils() {
    return _instance;
  }

  ModalUtils._internal();

  Future<void> showTimerEndModal(BuildContext context, TimerAlertType type, bool isAutoStartMode) async{
    final modalService = Provider.of<ModalService>(context, listen: false);
    String title = '';
    String message = '';
    bool showCancelButton = false;

    switch(type) {
      case TimerAlertType.focusTime:
        title = "🧠 집중 시간이에요!";
        message = "방해 금지!\n지금은 목표에 몰입할 시간이에요 💪";
        break;
      case TimerAlertType.shortBreakTime:
        title = "🍵 쉬는 시간이에요";
        message = "잠깐 숨 돌리고 스트레칭 어때요? 🙆‍♀️\n눈도 살짝 감아줘요 👀";
        break;
      case TimerAlertType.longBreakTime:
        title = "🧸 긴 휴식 시간이에요";
        message = "마지막 집중 세션 완료!\n지금은 푹 쉬어도 되는 시간이에요 🌈";
        break;
      case TimerAlertType.sessionFinished:
        title = "🎉 모든 세션 완료!";
        message = "정말 잘했어요!\n이제 자유 시간이에요 ✨";
        break;
    }

    await modalService.showCustomDialog(
        context: context,
        title: title,
        message: message,
        isAutoStartMode: isAutoStartMode,
        showCancelButton: showCancelButton,
    );
  }

}