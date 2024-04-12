import '/backend/api_requests/api_calls.dart';
import '/components/nodata_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String? tmpPath;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Custom Action - checkIsInstalledApp] action in Container widget.
  bool? isInstalled;
  // Stores action output result for [Custom Action - getAppMinifestData] action in Container widget.
  dynamic? appData;
  // Stores action output result for [Backend Call - API (installMiniApp)] action in Container widget.
  ApiCallResponse? apiResult2ow;
  // Stores action output result for [Custom Action - checkPermissionStorage] action in Container widget.
  bool? isGranted;
  // Stores action output result for [Custom Action - installApp] action in Container widget.
  dynamic? appData2;
  // Stores action output result for [Backend Call - API (installMiniApp)] action in Container widget.
  ApiCallResponse? apiResulttm4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
