import 'package:permission_handler/permission_handler.dart';
import 'package:pomodoro_timer/service/preference_service.dart';
import 'package:vibration/vibration.dart';

class VibrationService {
  final PreferenceService _preferenceService;

  VibrationService(this._preferenceService);

  bool get isVibrationEnabled => _preferenceService.getIsVibrateMode();

  Future<void> vibrate({int durationMs = 200}) async {
    if(!isVibrationEnabled) return;

    bool hasVibrator = await Vibration.hasVibrator() ?? false;
    bool hasPermission = await Permission.notification.isGranted;

    if(hasVibrator) {
      if(!hasPermission) {
        await Permission.notification.request();
      }

      if(await Permission.notification.isGranted) {
        Vibration.vibrate(duration: durationMs);
      }
    }
  }

  Future<void> saveIsVibrateMode(bool enabled) async {
    await _preferenceService.setIsVibrateMode(enabled);
  }

}