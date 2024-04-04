import '/flutter_flow/flutter_flow_util.dart';
import 'q_r_code_page_widget.dart' show QRCodePageWidget;
import 'package:flutter/material.dart';

class QRCodePageModel extends FlutterFlowModel<QRCodePageWidget> {
  ///  Local state fields for this page.

  String? qrcodeData;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  var rs = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
