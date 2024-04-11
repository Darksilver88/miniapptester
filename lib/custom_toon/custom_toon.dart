import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_app_tester/camera_page/camera_page_widget.dart';
import 'package:mini_app_tester/q_r_code_page/q_r_code_page_widget.dart';

generalHeader(headers) {
  headers["Os"] = 'Android';
  headers["App-Version"] = '1.0';
  headers["Os-Version"] = '3.0';
  headers["Lang"] = 'en';

  //headers["Accept"] = 'application/json';
  //headers["Content-Type"] = 'application/json';

  //headers["Access-Control-Allow-Origin"] = '*';
  //headers["Content-Type"] = 'application/json';

  //headers["Accept"] = '*/*';
  /*headers["User-Agent"] = 'PostmanRuntime/7.37.0';
  headers["Accept-Encoding"] = 'gzip, deflate, br';
  headers["Connection"] = 'keep-alive';*/

  return headers;
}

Future<dynamic> fetchData(url, data) async {
  print('fetchData');
  var response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return [];
  }
  List<dynamic> jsonData = json.decode(response.body);
  return jsonData;
}

Future<dynamic> reqFunction(url, context) async {
  print('reqFunction');
  if (url == "core://13A3/1.0.1/qrscanner/open_qrscanner") {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QRCodePageWidget()),
    );
  } else if (url == "core://13A3/1.0.1/camera/open_camera") {
    return  await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CameraPageWidget()),
    );
  } else {
    return "no function requested";
  }
}
