import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/enums/navigation_bar_page.dart';
import 'package:pomodoro_timer/enums/timer_type.dart';
import 'package:pomodoro_timer/screens/settings/widgets/theme_settings_section.dart';
import 'package:pomodoro_timer/screens/settings/widgets/toggle_settings_section.dart';
import 'package:pomodoro_timer/service/preference_service.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:pomodoro_timer/common_widgets/dialogs/timeadjust_dialog_widget.dart';
import 'package:pomodoro_timer/common_widgets/navigationBar/portrait_navbar_widget.dart';
import 'package:pomodoro_timer/service/vibration_service.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro_timer/screens/settings/widgets/time_settings_section.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late int focusTimeInMinutes;
  late int shortBreakTimeInMinutes;
  late int longBreakTimeInMinutes;

  //토글 메뉴
  bool isVibrateMode = true;
  bool isBackgroundMode = false;

  @override
  void initState() {
    super.initState();
    final timerService = Provider.of<TimerService>(context, listen: false);

    focusTimeInMinutes = timerService.focusTimeInMinutes;
    shortBreakTimeInMinutes = timerService.shortBreakTimeInMinutes;
    longBreakTimeInMinutes = timerService.longBreakTimeInMinutes;

    _loadAllSettings(); //비동기 설정 로드

    //화면 세로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  //dispose시 화면 방향 고정 해제
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  //시간 설정
  void setTime(TimerType type, int newSeconds) {
    setState(() {
      switch (type) {
        case TimerType.focus :
          focusTimeInMinutes = newSeconds;
          break;
        case TimerType.shortBreak :
          shortBreakTimeInMinutes = newSeconds;
          break;
        case TimerType.longBreak :
          longBreakTimeInMinutes = newSeconds;
          break;
      }
    });

    //TimerService 업데이트
    Provider.of<TimerService>(context, listen: false).setDurations(
        focusTimeInMinutes: focusTimeInMinutes,
        shortBreakTimeInMinutes: shortBreakTimeInMinutes,
        longBreakTimeInMinutes: longBreakTimeInMinutes
    );
  }

  //시간 조정 다이얼로그
  Future<void> _showTimeAdjustDialog(String title, int currentTime, TimerType type) async{
    await showDialog(
      context: context,
      builder: (context) => TimeAdjustDialog(
        title: title,
        initialTime: currentTime,
        onConfirm: (newTime) => setTime(type, newTime),
      ),
    );
  }

  //진동 관련 비동기 코드
  Future<void> _loadAllSettings() async {
    final prefs = Provider.of<PreferenceService>(context, listen: false);

    setState(() {
      isVibrateMode = prefs.getIsVibrateMode();
    });
  }


  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final selectedTheme = themeService.currentTheme;
    final timerService = Provider.of<TimerService>(context);
    final vibrationService = Provider.of<VibrationService>(context);

    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    final double topMargin = screenHeight * 0.07;
    final double landscapeHorizontalMargin = screenWidth * 0.15;
    final double horizontalPadding = (screenWidth * 0.06).clamp(20, 50);
    final double navigationBarIconSize = (screenWidth * 0.085).clamp(30, 40);
    final double sectionSpacing = screenHeight * 0.075;
    final double sectionTitleFontSize = (screenWidth * 0.045).clamp(10, 16);

    //시간 설정 관련
    final double timeCardWidth = (screenWidth * 0.28).clamp(80, 250);
    final double timerCardHeight = (screenWidth * 0.34).clamp(110, 190);
    final double timeCardFontSize = (screenHeight * 0.065).clamp(50, 80);

    //테마 설정 관련
    final double themeBoxSize = (screenWidth * 0.2).clamp(50, 150);
    final double themeColorDotSize = (screenWidth * 0.043).clamp(15, 50);

    return Scaffold(
      backgroundColor: selectedTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding).copyWith(top: topMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1. 시간 설정 섹션
              TimeSettingsSection(
                focusTime: focusTimeInMinutes,
                shortBreakTime: shortBreakTimeInMinutes,
                longBreakTime: longBreakTimeInMinutes,
                selectedTheme: selectedTheme,
                onTimeCardTap: _showTimeAdjustDialog,
                sectionTitleFontSize: sectionTitleFontSize,
                cardWidth: timeCardWidth,
                cardHeight: timerCardHeight,
                cardFontSize: timeCardFontSize,
              ),

              SizedBox(height: sectionSpacing),

              //2. 테마 설정 섹션
              ThemeSettingsSection(
                selectedTheme: selectedTheme,
                sectionTitleFontSize: sectionTitleFontSize,
                themeBoxSize: themeBoxSize,
                themeColorDotSize: themeColorDotSize,
              ),

              SizedBox(height: sectionSpacing),

              //3. 토글 설정 섹션
              ToggleSettingsSection(
                isVibrateMode: isVibrateMode,
                onVibrateModeChanged: (value) {
                  setState(() {
                    isVibrateMode = value;
                    vibrationService.saveIsVibrateMode(value);
                  });
                },
                isAutoStart: timerService.isAutoStart,
                onAutoStartChanged: (value) {
                  timerService.saveIsAutoStartMode(value);
                },
                selectedTheme: selectedTheme,
                sectionTitleFontSize: sectionTitleFontSize,
              ),

            ],
          ),
        ),
      ),

      //하단 네비게이션 바
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child:
            PortraitNavbar(
                iconSize: navigationBarIconSize,
                horizontalMargin: landscapeHorizontalMargin,
                currentPage: NavBarPage.settings,
            ),
        ),
      ),


    );
  }
}