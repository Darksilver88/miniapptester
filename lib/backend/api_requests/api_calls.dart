import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetMiniAppListByUserCall {
  static Future<ApiCallResponse> call({
    String? userID = '1',
    String? token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MTExOTExODQsImp0aSI6Ik9ETmpNMkUyWlRZdE16QmhNeTAwTnpGaExUaG1aall0TldGbFpqQTNPV1l3TmpaaCIsImlzcyI6InN1cGVyYXBwIiwibmJmIjoxNzExMTkxMTg0LCJleHAiOjE3MTExOTE3ODQsInZhbHVlcyI6eyJ1c2VybmFtZSI6ImFya29tckBnbWFpbC5jb20iLCJ1c2VyaWQiOiIzIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsIjotMSwidXNlcnByaW1hcnlrZXkiOiIzIiwicGVybWlzc2lvbiI6MH19.QCvFSaUiTWWs6peiAaMxNmzYM6PqlPKspKqnutG6G0G4E28tw2kJouktHBj3t-5B1Zo9KxhA7VIq0EZBya25Ig',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getMiniAppListByUser',
      apiUrl: 'https://superapp.kd3.dev/api/get_miniapp_list_tester/${userID}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class UninstallAppCall {
  static Future<ApiCallResponse> call({
    String? token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MTExOTExODQsImp0aSI6Ik9ETmpNMkUyWlRZdE16QmhNeTAwTnpGaExUaG1aall0TldGbFpqQTNPV1l3TmpaaCIsImlzcyI6InN1cGVyYXBwIiwibmJmIjoxNzExMTkxMTg0LCJleHAiOjE3MTExOTE3ODQsInZhbHVlcyI6eyJ1c2VybmFtZSI6ImFya29tckBnbWFpbC5jb20iLCJ1c2VyaWQiOiIzIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsIjotMSwidXNlcnByaW1hcnlrZXkiOiIzIiwicGVybWlzc2lvbiI6MH19.QCvFSaUiTWWs6peiAaMxNmzYM6PqlPKspKqnutG6G0G4E28tw2kJouktHBj3t-5B1Zo9KxhA7VIq0EZBya25Ig',
    String? appID = '',
    String? userID = '1',
  }) async {
    final ffApiRequestBody = '''
{
  "app_id": "${appID}",
  "user_id": "${userID}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'uninstallApp',
      apiUrl: 'https://superapp.kd3.dev/api/uninstall_app',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class InstallMiniAppCall {
  static Future<ApiCallResponse> call({
    String? miniappId = '',
    String? userId = '',
    String? installedPath = '',
    String? token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MTExOTExODQsImp0aSI6Ik9ETmpNMkUyWlRZdE16QmhNeTAwTnpGaExUaG1aall0TldGbFpqQTNPV1l3TmpaaCIsImlzcyI6InN1cGVyYXBwIiwibmJmIjoxNzExMTkxMTg0LCJleHAiOjE3MTExOTE3ODQsInZhbHVlcyI6eyJ1c2VybmFtZSI6ImFya29tckBnbWFpbC5jb20iLCJ1c2VyaWQiOiIzIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsIjotMSwidXNlcnByaW1hcnlrZXkiOiIzIiwicGVybWlzc2lvbiI6MH19.QCvFSaUiTWWs6peiAaMxNmzYM6PqlPKspKqnutG6G0G4E28tw2kJouktHBj3t-5B1Zo9KxhA7VIq0EZBya25Ig',
  }) async {
    final ffApiRequestBody = '''
{
  "miniapp_id": "${miniappId}",
  "user_id": "${userId}",
  "installed_path": "${installedPath}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'installMiniApp',
      apiUrl: 'https://superapp.kd3.dev/api/install_miniapp',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginuserCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'loginuser',
      apiUrl: 'https://superapp.kd3.dev/api/login_user/${username}/${password}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
