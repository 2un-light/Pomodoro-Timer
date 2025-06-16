import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';

class ToggleSettingsSection extends StatelessWidget {
  final bool isVibrateMode;
  final ValueChanged<bool> onVibrateModeChanged;
  final bool isAutoStart;
  final ValueChanged<bool> onAutoStartChanged;
  final AppTheme selectedTheme;
  final double sectionTitleFontSize;

  const ToggleSettingsSection({
    Key? key,
    required this.isVibrateMode,
    required this.onVibrateModeChanged,
    required this.isAutoStart,
    required this.onAutoStartChanged,
    required this.selectedTheme,
    required this.sectionTitleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 진동 여부 토글
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '진동 알림 여부',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: sectionTitleFontSize,
                color: selectedTheme.primaryTextColor,
              ),
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: isVibrateMode,
                onChanged: onVibrateModeChanged,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),

        // 자동 시작 옵션 토글
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '자동 시작 옵션',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: sectionTitleFontSize,
                color: selectedTheme.primaryTextColor,
              ),
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: isAutoStart,
                onChanged: onAutoStartChanged, // 콜백 함수 사용
              ),
            ),
          ],
        ),
      ],
    );
  }
}
