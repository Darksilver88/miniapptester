import '/flutter_flow/flutter_flow_util.dart';
import 'mini_app_page_widget.dart' show MiniAppPageWidget;
import 'package:flutter/material.dart';

class MiniAppPageModel extends FlutterFlowModel<MiniAppPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
