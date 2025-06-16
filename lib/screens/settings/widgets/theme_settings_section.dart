import 'package:flutter/material.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/theme/themes.dart';
import 'package:provider/provider.dart';

class ThemeSettingsSection extends StatelessWidget {
  final AppTheme selectedTheme;
  final double sectionTitleFontSize;
  final double themeBoxSize;
  final double themeColorDotSize;

  const ThemeSettingsSection({
    Key? key,

    required this.selectedTheme,
    required this.sectionTitleFontSize,
    required this.themeBoxSize,
    required this.themeColorDotSize,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            '테마 설정',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: sectionTitleFontSize,
              color: selectedTheme.primaryTextColor,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildThemeCard(context, whiteTheme),
              SizedBox(width: 15),
              _buildThemeCard(context, creamTheme),
              SizedBox(width: 15),
              _buildThemeCard(context, darkTheme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeCard(BuildContext context, AppTheme theme) {
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeService>(context, listen: false).setTheme(theme);
      },
      child: Container(
        padding: EdgeInsets.all(3),
        width: themeBoxSize,
        height: themeBoxSize,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildColorDot(theme.focusColor),
                _buildColorDot(theme.shortBreakColor),
                _buildColorDot(theme.longBreakColor),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      width: themeColorDotSize,
      height: themeColorDotSize,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

}
