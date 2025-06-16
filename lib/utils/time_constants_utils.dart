class TimeConstants {
  //사용자 설정 제한
  static const int minTime = 5;
  static const int maxTime = 60;
  static const int step = 5;

  //타이머 기본값
  static const int defaultFocusMinutes = 25;
  static const int defaultShortBreakMinutes = 5;
  static const int defaultLongBreakMinutes = 15;

  static const int defaultFocusSeconds = defaultFocusMinutes * 60;
  static const int defaultShortBreakSeconds = defaultShortBreakMinutes * 60;
  static const int defaultLongBreakSeconds = defaultLongBreakMinutes * 60;
}