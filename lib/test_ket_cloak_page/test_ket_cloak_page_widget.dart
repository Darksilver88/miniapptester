import 'package:flutter_keycloak/flutter_keycloak.dart';
import 'package:flutter_keycloak/token_storage.dart';
import 'package:get_storage/get_storage.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'test_ket_cloak_page_model.dart';
export 'test_ket_cloak_page_model.dart';

class TestKetCloakPageWidget extends StatefulWidget {
  const TestKetCloakPageWidget({super.key});

  @override
  State<TestKetCloakPageWidget> createState() => _TestKetCloakPageWidgetState();
}

class _TestKetCloakPageWidgetState extends State<TestKetCloakPageWidget> {
  late TestKetCloakPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final FlutterKeycloak _flutterKeycloak = FlutterKeycloak();
  late final TextEditingController _confController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _scopeController;

  String _currentPrefs = '';
  Map? _conf;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestKetCloakPageModel());
    GetStorage.init();
    _confController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _scopeController = TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void printStorage() {
    getCredentials().then((credentials) {
      setState(() {
        _currentPrefs =
        '${getConfiguration()}\n\n${getTokens()}\n\n$credentials';
      });
    });
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
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: _conf != null
                      ? ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _usernameController,
                              decoration:
                              const InputDecoration(hintText: 'Username'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              decoration:
                              const InputDecoration(hintText: 'Password'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _scopeController,
                              decoration:
                              const InputDecoration(hintText: 'Scope'),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _flutterKeycloak.login(
                            _conf,
                            _usernameController.text,
                            _passwordController.text,
                            scope: _scopeController.text != ''
                                ? _scopeController.text
                                : 'offline_access',
                          );
                          printStorage();
                        },
                        child: const Text('LOGIN'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final userInfo =
                          await _flutterKeycloak.retrieveUserInfo();
                          setState(() {
                            _currentPrefs = userInfo.toString();
                          });
                        },
                        child: const Text('GET USER INFO'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _flutterKeycloak.refreshLogin(
                            scope: 'offline_access',
                          );
                          printStorage();
                        },
                        child: const Text('REFRESH LOGIN'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _flutterKeycloak.refreshToken();
                          printStorage();
                        },
                        child: const Text('REFRESH TOKEN'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _flutterKeycloak.logout();
                          setState(() {
                            _currentPrefs = '';
                          });
                        },
                        child: const Text('LOGOUT'),
                      ),
                      if (_currentPrefs != '') Text(_currentPrefs),
                    ],
                  )
                      : Column(
                    children: [
                      TextFormField(
                        controller: _confController,
                        decoration: const InputDecoration(
                            hintText: 'Type here the config url'),
                      ),
                      ElevatedButton(
                        onPressed: () => _flutterKeycloak
                            .getConf(_confController.text)
                            .then((conf) => setState(() => _conf = conf)),
                        child: const Text('GET CONF AND PROCEED'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
