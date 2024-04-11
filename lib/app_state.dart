import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
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
      _installedAppDataList =
          prefs.getStringList('ff_installedAppDataList')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _installedAppDataList;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userData')) {
        try {
          _userData = jsonDecode(prefs.getString('ff_userData') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _installedAppDataList = [];
  List<dynamic> get installedAppDataList => _installedAppDataList;
  set installedAppDataList(List<dynamic> _value) {
    _installedAppDataList = _value;
    prefs.setStringList(
        'ff_installedAppDataList', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToInstalledAppDataList(dynamic _value) {
    _installedAppDataList.add(_value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromInstalledAppDataList(dynamic _value) {
    _installedAppDataList.remove(_value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromInstalledAppDataList(int _index) {
    _installedAppDataList.removeAt(_index);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void updateInstalledAppDataListAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _installedAppDataList[_index] = updateFn(_installedAppDataList[_index]);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInInstalledAppDataList(int _index, dynamic _value) {
    _installedAppDataList.insert(_index, _value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  dynamic _userData;
  dynamic get userData => _userData;
  set userData(dynamic _value) {
    _userData = _value;
    prefs.setString('ff_userData', jsonEncode(_value));
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
