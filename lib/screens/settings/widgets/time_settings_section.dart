import 'package:flutter/material.dart';
import 'package:pomodoro_timer/enums/timer_type.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';

typedef OnTimeCardTap = Future<void> Function(String title, int currentTime, TimerType type);

class TimeSettingsSection extends StatelessWidget {
  final int focusTime;
  final int shortBreakTime;
  final int longBreakTime;
  final AppTheme selectedTheme;
  final OnTimeCardTap onTimeCardTap;

  final double sectionTitleFontSize;
  final double cardWidth;
  final double cardHeight;
  final double cardFontSize;

  const TimeSettingsSection({
    Key? key,
    required this.focusTime,
    required this.shortBreakTime,
    required this.longBreakTime,
    required this.selectedTheme,
    required this.onTimeCardTap,
    required this.sectionTitleFontSize,
    required this.cardWidth,
    required this.cardHeight,
    required this.cardFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '시간 설정',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: sectionTitleFontSize,
              color: selectedTheme.primaryTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTimeCard('집중 시간', focusTime, TimerType.focus, selectedTheme.focusColor),
            _buildTimeCard('휴식 시간', shortBreakTime, TimerType.shortBreak, selectedTheme.shortBreakColor),
            _buildTimeCard('긴 휴식 시간', longBreakTime, TimerType.longBreak, selectedTheme.longBreakColor),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeCard(String title, int time, TimerType type, Color color) {
    return GestureDetector(
      onTap: () => onTimeCardTap(title, time, type),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$time', style: TextStyle(fontFamily: 'Pretendard', fontSize: cardFontSize, color: Colors.white)),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontFamily: 'Pretendard', fontSize: cardFontSize * 0.255, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}