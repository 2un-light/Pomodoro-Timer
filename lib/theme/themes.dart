import 'dart:ui';

import 'package:pomodoro_timer/model/app_theme_model.dart';

const AppTheme whiteTheme = AppTheme(
  name : 'white',
  backgroundColor: Color(0xFFFFFFFF),
  focusColor: Color(0xFFE63946),
  shortBreakColor: Color(0xFF4CAF50),
  longBreakColor: Color(0xFF0077B6),
  primaryTextColor: Color(0xFF333333),
  secondaryTextColor: Color(0xFF424242),
);

const AppTheme creamTheme = AppTheme(
    name: 'cream',
    backgroundColor: Color(0xFFFFFDE7),
    focusColor: Color(0xFFD62828),
    shortBreakColor: Color(0xFF388E3C),
    longBreakColor: Color(0xFF1565C0),
    primaryTextColor: Color(0xFF212121),
    secondaryTextColor: Color(0xFF424242),
);

const AppTheme darkTheme = AppTheme(
    name: 'dark',
    backgroundColor: Color(0xFF1E1E1E),
    focusColor: Color(0xFFFF6B6B),
    shortBreakColor: Color(0xFF6BCB77),
    longBreakColor: Color(0xFF4D96FF),
    primaryTextColor: Color(0xFFFFFFFF),
    secondaryTextColor: Color(0xFFE0E0E0),
);