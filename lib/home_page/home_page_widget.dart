import '/backend/api_requests/api_calls.dart';
import '/components/nodata_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: FutureBuilder<ApiCallResponse>(
              future:
                  (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
                        ..complete(GetMiniAppListByUserCall.call(
                          userID: '1',
                        )))
                      .future,
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                final gridViewGetMiniAppListByUserResponse = snapshot.data!;
                return Builder(
                  builder: (context) {
                    final appList = getJsonField(
                      gridViewGetMiniAppListByUserResponse.jsonBody,
                      r'''$.data''',
                    ).toList();
                    if (appList.isEmpty) {
                      return const NodataWidget();
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() => _model.apiRequestCompleter = null);
                        await _model.waitForApiRequestCompleted();
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          16.0,
                          0,
                          16.0,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.62,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: appList.length,
                        itemBuilder: (context, appListIndex) {
                          final appListItem = appList[appListIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var shouldSetState = false;
                              _model.isInstalled =
                                  await actions.checkIsInstalledApp(
                                getJsonField(
                                  appListItem,
                                  r'''$.app_id''',
                                ).toString(),
                              );
                              shouldSetState = true;
                              if (_model.isInstalled!) {
                                _model.appData =
                                    await actions.getAppMinifestData(
                                  getJsonField(
                                    appListItem,
                                    r'''$.app_id''',
                                  ).toString(),
                                );
                                shouldSetState = true;
                                _model.apiResult2ow =
                                    await InstallMiniAppCall.call(
                                  miniappId: getJsonField(
                                    appListItem,
                                    r'''$.app_id''',
                                  ).toString(),
                                  userId: '1',
                                  installedPath: getJsonField(
                                    _model.appData,
                                    r'''$.path''',
                                  ).toString(),
                                );
                                shouldSetState = true;
                                setState(
                                    () => _model.apiRequestCompleter = null);
                                await _model.waitForApiRequestCompleted();

                                context.pushNamed(
                                  'MiniAppPage',
                                  queryParameters: {
                                    'appName': serializeParam(
                                      getJsonField(
                                        appListItem,
                                        r'''$.title''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                    'url': serializeParam(
                                      getJsonField(
                                        _model.appData,
                                        r'''$.path''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              } else {
                                _model.isGranted =
                                    await actions.checkPermissionStorage();
                                shouldSetState = true;
                                if (_model.isGranted!) {
                                  if (getJsonField(
                                        appListItem,
                                        r'''$.is_install''',
                                      ) !=
                                      functions.isTrue()) {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return WebViewAware(
                                                  child: AlertDialog(
                                                    title: const Text('Install App?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: const Text('Confirm'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (!confirmDialogResponse) {
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }
                                  }
                                  _model.appData2 = await actions.installApp(
                                    getJsonField(
                                      appListItem,
                                      r'''$.url''',
                                    ).toString(),
                                    getJsonField(
                                      appListItem,
                                      r'''$.app_id''',
                                    ).toString(),
                                  );
                                  shouldSetState = true;
                                  FFAppState().addToInstalledAppDataList(
                                      _model.appData2!);
                                  _model.apiResulttm4 =
                                      await InstallMiniAppCall.call(
                                    miniappId: getJsonField(
                                      appListItem,
                                      r'''$.app_id''',
                                    ).toString(),
                                    userId: '1',
                                    installedPath: getJsonField(
                                      _model.appData2,
                                      r'''$.path''',
                                    ).toString(),
                                  );
                                  shouldSetState = true;
                                  setState(
                                      () => _model.apiRequestCompleter = null);
                                  await _model.waitForApiRequestCompleted();

                                  context.pushNamed(
                                    'MiniAppPage',
                                    queryParameters: {
                                      'appName': serializeParam(
                                        getJsonField(
                                          appListItem,
                                          r'''$.title''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'url': serializeParam(
                                        getJsonField(
                                          _model.appData2,
                                          r'''$.path''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                }
                              }

                              if (shouldSetState) setState(() {});
                            },
                            onLongPress: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return WebViewAware(
                                            child: AlertDialog(
                                              title: const Text('Uninstall ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: const Text('Confirm'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                await UninstallAppCall.call(
                                  appID: getJsonField(
                                    appListItem,
                                    r'''$.app_id''',
                                  ).toString(),
                                  userID: '1',
                                );
                                FFAppState()
                                    .removeAtIndexFromInstalledAppDataList(
                                        functions.getAppIndex(
                                            getJsonField(
                                              appListItem,
                                              r'''$.app_id''',
                                            ).toString(),
                                            FFAppState()
                                                .installedAppDataList
                                                .toList()));
                                setState(
                                    () => _model.apiRequestCompleter = null);
                                await _model.waitForApiRequestCompleted();
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 4.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              getJsonField(
                                                appListItem,
                                                r'''$.icon''',
                                              ).toString(),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/error_image.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (getJsonField(
                                            appListItem,
                                            r'''$.is_install''',
                                          ))
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  1.0, 1.0),
                                              child: Icon(
                                                Icons.check_circle,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                size: 24.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        getJsonField(
                                          appListItem,
                                          r'''$.title''',
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
