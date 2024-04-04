import '/flutter_flow/flutter_flow_util.dart';
import 'camera_page_widget.dart' show CameraPageWidget;
import 'package:flutter/material.dart';

class CameraPageModel extends FlutterFlowModel<CameraPageWidget> {
  ///  Local state fields for this page.

  String? photoBase64;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
