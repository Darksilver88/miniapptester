// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermissionStorage() async {
  // Add your function code here!
  print("checkPermissionStorage");
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    print("info.version.release : ${info.version.release}");
    if (int.parse(info.version.release) >= 13) {
      return true;
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    }
  }
  return false;
}
