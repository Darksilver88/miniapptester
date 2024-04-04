import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _appInstalledList = prefs.getStringList('ff_appInstalledList')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _appInstalledList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _appInstalledList = [];
  List<dynamic> get appInstalledList => _appInstalledList;
  set appInstalledList(List<dynamic> value) {
    _appInstalledList = value;
    prefs.setStringList(
        'ff_appInstalledList', value.map((x) => jsonEncode(x)).toList());
  }

  void addToAppInstalledList(dynamic value) {
    _appInstalledList.add(value);
    prefs.setStringList('ff_appInstalledList',
        _appInstalledList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromAppInstalledList(dynamic value) {
    _appInstalledList.remove(value);
    prefs.setStringList('ff_appInstalledList',
        _appInstalledList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromAppInstalledList(int index) {
    _appInstalledList.removeAt(index);
    prefs.setStringList('ff_appInstalledList',
        _appInstalledList.map((x) => jsonEncode(x)).toList());
  }

  void updateAppInstalledListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _appInstalledList[index] = updateFn(_appInstalledList[index]);
    prefs.setStringList('ff_appInstalledList',
        _appInstalledList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInAppInstalledList(int index, dynamic value) {
    _appInstalledList.insert(index, value);
    prefs.setStringList('ff_appInstalledList',
        _appInstalledList.map((x) => jsonEncode(x)).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
