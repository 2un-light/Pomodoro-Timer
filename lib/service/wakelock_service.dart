
import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  //화면 꺼짐 방지 활성화
  void enable() {
    WakelockPlus.enable();
  }

  //화면 꺼짐 방지 비활성화
  void disable() {
    WakelockPlus.disable();
  }

  //현재 상태 확인
  Future<bool> isEnabled() {
    return WakelockPlus.enabled;
  }
}