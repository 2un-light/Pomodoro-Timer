import 'package:pomodoro_timer/utils/time_constants_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final SharedPreferences _prefs;

  PreferenceService(this._prefs);

  static const String _focusKey = 'focusSeconds';
  static const String _shortBreakKey = 'shortBreakSeconds';
  static const String _longBreakKey = 'longBreakSeconds';
  static const String _isVibrateKey = 'isVibrateMode';
  static const String _isAutoStartKey = 'isAutoStartMode';
  static const String _themeKey = 'selectedTheme';

  int getFocusSeconds() => _prefs.getInt(_focusKey) ?? TimeConstants.defaultFocusSeconds;
  Future<void> setFocusSeconds(int seconds) async => await _prefs.setInt(_focusKey, seconds);

  int getShortBreakSeconds() => _prefs.getInt(_shortBreakKey) ?? TimeConstants.defaultShortBreakSeconds;
  Future<void> setShortBreakSeconds(int seconds) async => await _prefs.setInt(_shortBreakKey, seconds);

  int getLongBreakSeconds() => _prefs.getInt(_longBreakKey) ?? TimeConstants.defaultLongBreakSeconds;
  Future<void> setLongBreakSeconds(int seconds) async => await _prefs.setInt(_longBreakKey, seconds);

  bool getIsVibrateMode() => _prefs.getBool(_isVibrateKey) ?? false;
  Future<void> setIsVibrateMode(bool isVibrateMode) async => await _prefs.setBool(_isVibrateKey, isVibrateMode);

  bool getIsAutoStartMode() => _prefs.getBool(_isAutoStartKey) ?? false;
  Future<void> setIsAutoStartMode(bool isAutoStartMode) async => await _prefs.setBool(_isAutoStartKey, isAutoStartMode);

  String? getSelectedThemeName() => _prefs.getString(_themeKey);
  Future<void> setSelectedThemeName(String themeName) async => await _prefs.setString(_themeKey, themeName);

}