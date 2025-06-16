import 'package:flutter/material.dart';
import 'package:pomodoro_timer/service/vibration_service.dart';
import 'package:pomodoro_timer/common_widgets/dialogs/custom_dialog_widget.dart';

class ModalService {

  final VibrationService _vibrationService;

  ModalService(this._vibrationService);


  Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "확인",
    String cancelText = "취소",
    bool showCancelButton = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isAutoStartMode = false,
  }) async {

    await _vibrationService.vibrate();

    return showDialog(
      context: context,
      //자동 시작 모드일 때는 사용자가 탭해서 닫지 못하게 설정
      barrierDismissible: !isAutoStartMode,
      builder: (BuildContext context) {
        return CustomDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          showCancelButton: showCancelButton,
          onConfirm: onConfirm,
          onCancel: onCancel,
          isAutoStartMode: isAutoStartMode,
        );
      },
    );
  }
}