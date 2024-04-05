// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> getAppMinifestData(String? appID) async {
  // Add your function code here!
  print("getAppMinifestData");
  return FFAppState().installedAppDataList.firstWhere(
        (item) => item['app_id'] == appID, // Check for matching app_id
        orElse: () => null, // Return null if not found
      );
}
