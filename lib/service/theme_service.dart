import 'package:flutter/material.dart';
import 'package:pomodoro_timer/model/app_theme_model.dart';
import 'package:pomodoro_timer/service/preference_service.dart';
import 'package:pomodoro_timer/theme/themes.dart';

class ThemeService extends ChangeNotifier {
  final PreferenceService _preferenceService;

  ThemeService(this._preferenceService);

  AppTheme _currentTheme = creamTheme;
  AppTheme get currentTheme => _currentTheme;

  final Map<String, AppTheme> _themeMap = {
    'white' : whiteTheme,
    'cream' : creamTheme,
    'dark' : darkTheme,
  };

  Future<void> loadTheme() async {
    final themeName = _preferenceService.getSelectedThemeName();

    if(themeName != null && _themeMap.containsKey(themeName)) {
      _currentTheme = _themeMap[themeName]!;
    }
    notifyListeners();
  }
  
  void setTheme(AppTheme theme) async {
    _currentTheme = theme;
    notifyListeners();
    await _preferenceService.setSelectedThemeName(theme.name);
  }

}