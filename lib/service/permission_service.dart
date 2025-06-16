import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  //알림 권한 요청
  Future<bool> requestNotificationPermissionIfNeeded() async {
    final status = await Permission.notification.status;

    if(status.isDenied || status.isRestricted) {
      final result = await Permission.notification.request();
      if(result.isGranted) {
        debugPrint("✅ 알림 권한 허용됨");
        return true;
      }else {
        debugPrint("❌ 알림 권한 거부됨");
        return false;
      }
    }
    return true;
  }
}