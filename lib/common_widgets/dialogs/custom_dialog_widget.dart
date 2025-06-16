import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatefulWidget {

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool showCancelButton;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isAutoStartMode;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmText = "확인",
    this.cancelText = "취소",
    this.showCancelButton = false,
    this.onConfirm,
    this.onCancel,
    this.isAutoStartMode = false,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();

}

  class _CustomDialogState extends State<CustomDialog> {
    Timer? _timer;
    int _countdown = 3;

    @override
    void initState() {
      super.initState();
      if(widget.isAutoStartMode) {
        _startCountdown();
    }
  }

  void _startCountdown() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if(_countdown > 0) {
          setState(() {
            _countdown--;
          });
        }else {
          _timer?.cancel();
          if(mounted && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      });
  }

  void dispose() {
      _timer?.cancel();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    AppTheme selectedTheme = themeService.currentTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: selectedTheme.name == 'dark' ? selectedTheme.backgroundColor : Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: selectedTheme.primaryTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 15,
                color: selectedTheme.secondaryTextColor,
              ),
            ),

            if(widget.isAutoStartMode)
              Padding(
                  padding:  EdgeInsets.only(top: 16),
                  child:Text(
                    '$_countdown', // <--- 카운트다운 값 표시
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 25, // 카운트다운 숫자를 더 크게 표시
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50), // 눈에 띄는 색상
                    ),
                  ),
              ),

            const SizedBox(height: 20),

            if(!widget.isAutoStartMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.showCancelButton)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (widget.onCancel != null) widget.onCancel!();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF9E9E9E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(widget.cancelText, style: const TextStyle(fontFamily: 'Pretendard')),
                    ),
                  if (widget.showCancelButton) const SizedBox(width: 40),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.onConfirm != null) widget.onConfirm!();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(widget.confirmText, style: const TextStyle(fontFamily: 'Pretendard')),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
