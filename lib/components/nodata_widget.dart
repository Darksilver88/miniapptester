import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nodata_model.dart';
export 'nodata_model.dart';

class NodataWidget extends StatefulWidget {
  const NodataWidget({super.key});

  @override
  State<NodataWidget> createState() => _NodataWidgetState();
}

class _NodataWidgetState extends State<NodataWidget> {
  late NodataModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NodataModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        'No data',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 32.0,
              letterSpacing: 0.0,
            ),
      ),
    );
  }
}
