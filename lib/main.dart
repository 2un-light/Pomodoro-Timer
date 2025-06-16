import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';
import 'package:pomodoro_timer/screens/home/home_screen.dart';
import 'package:pomodoro_timer/service/modal_service.dart';
import 'package:pomodoro_timer/service/preference_service.dart';
import 'package:pomodoro_timer/service/theme_service.dart';
import 'package:pomodoro_timer/service/timer_service.dart';
import 'package:pomodoro_timer/service/vibration_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();
  final preferenceService = PreferenceService(sharedPrefs);

  final vibrationService = VibrationService(preferenceService);
  final timerService = TimerService(preferenceService);
  final themeService = ThemeService(preferenceService);
  await themeService.loadTheme();

  final modalService = ModalService(vibrationService);

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => timerService),
          ChangeNotifierProvider(create: (_) => themeService),
          Provider<PreferenceService>.value(value: preferenceService),
          Provider<VibrationService>.value(value: vibrationService),
          Provider<ModalService>.value(value: modalService),
        ],
        child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeService _themeService;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
    );
  }

  @override
  void didChangeDependencies() {
    _themeService = Provider.of<ThemeService>(context);
    AppTheme selectedTheme = _themeService.currentTheme;

    // 상태바 색상을 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: (selectedTheme.name == 'dark') ? Brightness.light : Brightness.dark,

      systemNavigationBarColor: selectedTheme.backgroundColor,
      systemNavigationBarIconBrightness: (selectedTheme.name == 'dark') ? Brightness.light : Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ));
  }
}