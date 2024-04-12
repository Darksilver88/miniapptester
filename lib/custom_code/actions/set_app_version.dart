// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:package_info_plus/package_info_plus.dart';

Future setAppVersion() async {
  // Add your function code here!
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '',
    buildNumber: '',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  final info = await PackageInfo.fromPlatform();
  _packageInfo = info;
  FFAppState().update(() {
    FFAppState().appVersion =
        'Ver ${_packageInfo.version} (${_packageInfo.buildNumber})';
  });
}
