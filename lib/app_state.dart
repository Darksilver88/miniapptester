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
  set installedAppDataList(List<dynamic> value) {
    _installedAppDataList = value;
    prefs.setStringList(
        'ff_installedAppDataList', value.map((x) => jsonEncode(x)).toList());
  }

  void addToInstalledAppDataList(dynamic value) {
    _installedAppDataList.add(value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromInstalledAppDataList(dynamic value) {
    _installedAppDataList.remove(value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromInstalledAppDataList(int index) {
    _installedAppDataList.removeAt(index);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void updateInstalledAppDataListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _installedAppDataList[index] = updateFn(_installedAppDataList[index]);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInInstalledAppDataList(int index, dynamic value) {
    _installedAppDataList.insert(index, value);
    prefs.setStringList('ff_installedAppDataList',
        _installedAppDataList.map((x) => jsonEncode(x)).toList());
  }

  dynamic _userData;
  dynamic get userData => _userData;
  set userData(dynamic value) {
    _userData = value;
    prefs.setString('ff_userData', jsonEncode(value));
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
