import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/enums/timer_alert_type.dart';
import 'package:pomodoro_timer/service/preference_service.dart';
import 'package:pomodoro_timer/service/wakelock_service.dart';

class TimerService extends ChangeNotifier {
  final WakelockService _wakelock = WakelockService();
  final PreferenceService _preferenceService;

  late int focusSeconds;
  late int shortBreakSeconds;
  late int longBreakSeconds;
  late bool isAutoStart;

  int _sessionCount = 0;
  int _duration = 0;
  bool _isTimerRunning = false;
  bool _isTimerPaused = false;
  bool _isFocusTime = true;
  bool _isShortBreakTime = false;
  bool _isLongBreakTime = false;
  bool _isSessionFinished = false;
  Timer? _timer;

  //Getter
  int get sessionCount => _sessionCount;
  int get duration => _duration;
  bool get isTimerRunning => _isTimerRunning;
  bool get isTimerPaused => _isTimerPaused;
  bool get isFocusTime => _isFocusTime;
  bool get isShortBreakTime => _isShortBreakTime;
  bool get isLongBreakTime => _isLongBreakTime;
  bool get isSessionFinished => _isSessionFinished;

  int get focusTimeInMinutes => focusSeconds ~/ 60;
  int get shortBreakTimeInMinutes => shortBreakSeconds ~/ 60;
  int get longBreakTimeInMinutes => longBreakSeconds ~/ 60;

  TimerService(this._preferenceService) {
    _loadAllSettings();
  }

  Future<void> Function(TimerAlertType type, bool isAutoStartMode)? onTimerEndCallback;

  ///타이머 시작 및 재생 함수
  void startTimer({bool resetDuration = true}) async {
    if (_isTimerRunning) return;

    //화면 꺼짐 방지
    _wakelock.enable();

    if (resetDuration) {
      _duration = _getDuration();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (duration > 0) {
        _duration--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _onTimerEnd();
      }
    });

    _isTimerRunning = true;
    _isTimerPaused = false;
    notifyListeners();
  }

  ///타이머 일시정지 함수
  void pauseTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
    }

    //화면 꺼짐 방지 해제
    _wakelock.disable();

    _isTimerRunning = false;
    _isTimerPaused = true;
    notifyListeners();
  }

  ///타이머 재개 함수
  void resumeTimer() {
    startTimer(resetDuration: false);
    _isTimerRunning = true;
    notifyListeners();
  }

  ///타이머 재시작(초기화 후 새로 시작)
  void restartTimer() {
    _isTimerRunning = false;
    _isTimerPaused = false;
    _isSessionFinished = false;
    _duration = _getDuration();
    notifyListeners();
  }

  ///타이머 취소
  void cancelTimer() {
    _timer?.cancel();

    //화면 꺼짐 방지 해제
    _wakelock.disable();

    _isTimerRunning = false;
    _isTimerPaused = false;
    _sessionCount = 0;
    _isFocusTime = true;
    _isShortBreakTime = false;
    _isLongBreakTime = false;
    _isSessionFinished = false;
    _duration = _getDuration();
    notifyListeners();
  }

  ///타이머 종료 시 모달창을 띄우는 함수
  void _onTimerEnd() async {
    _isTimerRunning = false;
    _isTimerPaused = false;

    //화면 꺼짐 방지 해제
    _wakelock.disable();

    TimerAlertType alertType;

    if (_isFocusTime) {
      _sessionCount++;
      _isFocusTime = false;
      if (_sessionCount % 4 == 0) {
        _isLongBreakTime = true;
        alertType = TimerAlertType.longBreakTime;
        _isShortBreakTime = false;
        _duration = _getDuration();
      } else {
        _isShortBreakTime = true;
        alertType = TimerAlertType.shortBreakTime;
        _isLongBreakTime = false;
        _duration = _getDuration();
      }
    } else {
      _isFocusTime = true;
      if (isLongBreakTime) {
        _isSessionFinished = true;
        alertType = TimerAlertType.sessionFinished;
        _duration = _getDuration();
      } else {
        alertType = TimerAlertType.focusTime;
        _duration = _getDuration();
      }
      _isShortBreakTime = false;
      _isLongBreakTime = false;
    }

    notifyListeners();

    //콜백함수 호출 (타이머 완료시)
    if (onTimerEndCallback != null) {
      await onTimerEndCallback!(alertType, isAutoStart);
    }

    if(isAutoStart && !isSessionFinished) {
      startTimer();
    }
  }

  ///현재 상태에 따라 기본 타이머 시간 반환
  int _getDuration() {
    if (_isFocusTime) {
      return focusSeconds;
    } else if (_isShortBreakTime) {
      return shortBreakSeconds;
    } else {
      return longBreakSeconds;
    }
  }

  //저장된 시간 불러오기(비동기)
  Future<void> _loadAllSettings() async {
    focusSeconds = _preferenceService.getFocusSeconds();
    shortBreakSeconds = _preferenceService.getShortBreakSeconds();
    longBreakSeconds = _preferenceService.getLongBreakSeconds();
    isAutoStart = _preferenceService.getIsAutoStartMode();
    _duration = _getDuration();
    notifyListeners();
  }

  void setDurations({required int focusTimeInMinutes, required int shortBreakTimeInMinutes, required int longBreakTimeInMinutes}) {
    focusSeconds = focusTimeInMinutes * 60;
    shortBreakSeconds = shortBreakTimeInMinutes * 60;
    longBreakSeconds = longBreakTimeInMinutes * 60;
    _duration = _getDuration();
    saveDurations(focusSeconds, shortBreakSeconds, longBreakSeconds);
    notifyListeners();
  }

  //변경된 시간 저장하기
  Future<void> saveDurations(int focusSeconds, int shortBreakSeconds, int longBreakSeconds) async {
    await _preferenceService.setFocusSeconds(focusSeconds);
    await _preferenceService.setShortBreakSeconds(shortBreakSeconds);
    await _preferenceService.setLongBreakSeconds(longBreakSeconds);
  }

  //설정(자동 시작 모드 여부) 저장
  Future<void> saveIsAutoStartMode(bool isAutoStartMode) async {
    isAutoStart = isAutoStartMode;
    await _preferenceService.setIsAutoStartMode(isAutoStart);
    notifyListeners();
  }

}
