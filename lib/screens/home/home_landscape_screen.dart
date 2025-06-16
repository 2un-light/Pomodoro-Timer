import 'package:flutter/material.dart';
import 'package:pomodoro_timer/enums/navigation_bar_page.dart';
import 'package:pomodoro_timer/enums/timer_alert_type.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:pomodoro_timer/utils/modal_utils.dart';
import 'package:pomodoro_timer/utils/time_utils.dart';
import 'package:pomodoro_timer/common_widgets/navigationBar/landscape_navbar_widget.dart';
import 'package:pomodoro_timer/screens/home/widgets/tomato_icons_widget.dart';
import 'package:provider/provider.dart';

class HomeLandscapeScreen extends StatefulWidget {
  const HomeLandscapeScreen({super.key});

  @override
  State<HomeLandscapeScreen> createState() => _HomeLandscapeScreenState();
}

class _HomeLandscapeScreenState extends State<HomeLandscapeScreen> {
  TimerService? _timerService;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _timerService = Provider.of<TimerService>(context, listen: false);
      _timerService!.onTimerEndCallback = (TimerAlertType type, bool isAutoStartMode) async{
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

    double landscapeTopMargin = screenHeight * 0.06;
    double landscapeHorizontalMargin = screenWidth * 0.1;
    double spacingAfterTimer = screenHeight * 0.025;

    double timerFontSize = screenWidth * 0.18;
    double timerLetterSpacing = screenWidth * 0.06;
    double tomatoIconSize = screenWidth * 0.047;
    double navigationBarIconSize = screenWidth * 0.043;
    double timerControlButtonIconSize = screenWidth * 0.04;

    return Consumer<TimerService>(
      builder: (context, timerService, child) {
        return Scaffold(
          backgroundColor: selectedTheme.backgroundColor,
          body: Container(
            margin: EdgeInsets.only(top: landscapeTopMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TomatoIcons(tomatoIconSize: tomatoIconSize),
                Text(
                  formatTime(timerService.duration),
                  style: TextStyle(
                    fontSize: timerFontSize,
                    fontFamily: 'MoiraiOne',
                    color: timerService.isFocusTime
                        ? selectedTheme.focusColor
                        : (timerService.isShortBreakTime
                        ? selectedTheme.shortBreakColor
                        : selectedTheme.longBreakColor),
                    letterSpacing: timerLetterSpacing,
                  ),
                ),
                SizedBox(height: spacingAfterTimer),
                // _buildLandscapeNavBar(context, navigationBarIconSize, timerButtonIconSize, landscapeHorizontalMargin),

                //하단 네비게이션바
                LandscapeNavBar(
                    iconSize: navigationBarIconSize,
                    timerControlButtonIconSize: timerControlButtonIconSize,
                    horizonalMargin: landscapeHorizontalMargin,
                    currentPage: NavBarPage.home
                ),
              ],
            ),
          ),

        );
      },
    );
  }


}
