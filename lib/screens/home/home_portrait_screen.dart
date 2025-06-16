import 'package:flutter/material.dart';
import 'package:pomodoro_timer/animations/long_break_time_animation.dart';
import 'package:pomodoro_timer/animations/short_break_time_animation.dart';
import 'package:pomodoro_timer/animations/working_time_animation.dart';
import 'package:pomodoro_timer/enums/navigation_bar_page.dart';
import 'package:pomodoro_timer/enums/timer_alert_type.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:pomodoro_timer/utils/modal_utils.dart';
import 'package:pomodoro_timer/utils/time_utils.dart';
import 'package:pomodoro_timer/common_widgets/navigationBar/portrait_navbar_widget.dart';
import 'package:pomodoro_timer/screens/home/widgets/timer_control_buttons_widget.dart';
import 'package:pomodoro_timer/screens/home/widgets/tomato_icons_widget.dart';
import 'package:provider/provider.dart';

class HomePortraitScreen extends StatefulWidget {
  @override
  _HomePortraitScreenState createState() => _HomePortraitScreenState();
}

class _HomePortraitScreenState extends State<HomePortraitScreen> {
  TimerService? _timerService;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _timerService = Provider.of<TimerService>(context, listen: false);
      _timerService!.onTimerEndCallback = (TimerAlertType type, bool isAutoStartMode) async {
        await ModalUtils().showTimerEndModal(context, type, isAutoStartMode);
      };
    });
  }

  @override
  void dispose() {
    _timerService?.onTimerEndCallback = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    final themeService = Provider.of<ThemeService>(context);
    final selectedTheme = themeService.currentTheme;

    double topMargin = screenHeight * 0.13;
    double spacingAfterTimer = screenHeight * 0.025;
    double spacingAfterImage = screenHeight * 0.05;

    double tomatoIconSize = (screenWidth * 0.05).clamp(30, 50);
    double timerFontSize = (screenWidth * 0.25).clamp(50, 150);
    double timerLetterSpacing = screenWidth * 0.03;
    double videoWidthSize = (screenWidth * 0.7).clamp(200, 350);
    double videoHeightSize = (screenHeight * 0.4).clamp(300, 450);
    double timerButtonIconSize = (screenWidth * 0.08).clamp(30, 40);

    double landscapeHorizontalMargin = screenWidth * 0.15;
    double navigationBarIconSize = (screenWidth * 0.085).clamp(30, 40);

    return Consumer<TimerService>(
      builder: (context, timerService, child) {
        return Scaffold(
          backgroundColor: selectedTheme.backgroundColor,
          body: Container(
            margin: EdgeInsets.only(top: topMargin),
            child: Column(
              children: [
                TomatoIcons(tomatoIconSize: tomatoIconSize),
                Text(
                  formatTime(timerService.duration),
                  style: TextStyle(
                    fontSize: timerFontSize,
                    fontFamily: 'MoiraiOne',
                    color: timerService.isFocusTime
                        ? selectedTheme.focusColor
                        : (timerService.isShortBreakTime ? selectedTheme.shortBreakColor : selectedTheme.longBreakColor),
                    letterSpacing: timerLetterSpacing,
                  ),
                ),
                SizedBox(height: spacingAfterTimer),
                timerService.isFocusTime
                    ? WorkingTimeAnimation(width: videoWidthSize, height: videoHeightSize, isRunning: timerService.isTimerRunning, themeName: selectedTheme.name,)
                    : (timerService.isShortBreakTime
                    ? ShortBreakTimeAnimation(width: videoWidthSize, height: videoHeightSize, isRunning: timerService.isTimerRunning, themeName: selectedTheme.name)
                    : LongBreakTimeAnimation(width: videoWidthSize, height: videoHeightSize, isRunning: timerService.isTimerRunning, themeName: selectedTheme.name)),
                SizedBox(height: spacingAfterImage),
                timerControlButtons(context, timerButtonIconSize),
              ],
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
                  currentPage: NavBarPage.home
                ),
            ),
          ),

        );
      },
    );
  }
}