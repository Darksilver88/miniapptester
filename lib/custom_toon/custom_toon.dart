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

Map<String, dynamic> getCmd(String cmd){

  cmd = cmd.replaceAll("//", "/");
  cmd = cmd.replaceAll(":", "");
  List<String> cmdList = cmd.split("/");
  Map<String, dynamic> cmdResult = {};

  //เพิ่มการตรวจสอบ uri ตรงนี้หน่อยครับ ดักการเรียกที่ไม่ถูกต้อง , การเรียกในสิ่งที่ไม่มีให้ใช้
  if( cmdList.length < 4) {
    cmdResult["status"] = -1;
    cmdResult["message"] = "Invalid URI";
    return cmdResult;
  }

  if( cmdList[0] != "core" ) {
    cmdResult["status"] = -1;
    cmdResult["message"] = "Invalid URI";
    return cmdResult;
  }

  cmdResult["status"] = 1;
  cmdResult["cmd"] = cmdList;
  //เพิ่มการดึง parameter ออกมาด้วยครับ
  // cmdResult["query"] = {"param1": "valu1", "param2": "valu2"};
  return cmdResult;
}

Future<dynamic> reqFunction(url, context) async {
  Map<String, dynamic> cmd = getCmd(url);
  int status = cmd["status"];
  if( status == -1){
    return  cmd["message"];
  }
  List<String> cmdList = cmd["cmd"];
  String featureName = cmdList[3];
  String functionName = cmdList.length <= 4 ? "" : cmdList[4];
  debugPrint("featureName=$featureName");
  debugPrint("functionName=$functionName");

  if( featureName == "qrscanner"){
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QRCodePageWidget()),
    );
  } else if (featureName == "camera") {
    return  await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CameraPageWidget()),
    );
  } else if (featureName == "get_miniapp_manifest") {
    //เพิ่มการอ่าน minifest file ของ miniapp แล้วตอบกลับไป
    return null;
  } else {
    return "no function requested";
  }
/*
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
  }*/
}
