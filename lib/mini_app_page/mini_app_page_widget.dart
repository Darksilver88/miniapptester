import 'package:mini_app_tester/index.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'mini_app_page_model.dart';
export 'mini_app_page_model.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/scheduler.dart';
import 'package:mini_app_tester/custom_toon/custom_toon.dart';



class MiniAppPageWidget extends StatefulWidget {
  const MiniAppPageWidget({
    super.key,
    String? appName,
    required this.url,
  }) : this.appName = appName ?? 'mini app';

  final String appName;
  final String? url;

  @override
  State<MiniAppPageWidget> createState() => _MiniAppPageWidgetState();
}

class _MiniAppPageWidgetState extends State<MiniAppPageWidget> {
  late MiniAppPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final InAppLocalhostServer localhostServer = InAppLocalhostServer();
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MiniAppPageModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await localhostServer.start();
    });
  }

  void _onMiniAppCreated(){
    _webViewController?.evaluateJavascript(source: 'window.app.onLoad()');
  }

  void _onMiniAppHide(){
    _webViewController?.evaluateJavascript(source: 'window.app.onHide()');
  }

  void _initCommunicationChannel(InAppWebViewController controller){
    controller.addJavaScriptHandler(handlerName: "post", callback: (args) {
      debugPrint("post From the JavaScript side:");
      debugPrint("$args");
      //http request
      return args;
    });

    controller.addJavaScriptHandler(handlerName: "get", callback: (args) async {
      debugPrint("get From the JavaScript side:");
      debugPrint("$args");
      //http request
      print(args[0]["url"]);
      print(args[0]["data"]);
      var rs = await fetchData(args[0]["url"], args[0]["data"]);
      return rs;
    });

    controller.addJavaScriptHandler(handlerName: "request", callback: (args) async {
      debugPrint("request From the JavaScript side:");
      debugPrint("$args");
      //request to use core feature
      var rs = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => QRCodePageWidget()),
      );
      return rs;
    });
  }

  @override
  void dispose() {
    _model.dispose();
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            widget.appName,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("http://localhost:8080${widget.url}")),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              controller.setOptions(
                options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(cacheEnabled: true, supportZoom: false),
                ),
              );
            },
            onLoadStop: (controller, url) {
              print("onLoadStop : $url");
              _onMiniAppCreated();
              _initCommunicationChannel(controller);
            },
            onConsoleMessage: (controller, msg) {
              print("onConsoleMessage");
              print(msg);
            },
          ),
        ),
      ),
    );
  }
}
