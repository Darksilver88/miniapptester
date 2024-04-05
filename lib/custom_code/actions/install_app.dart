// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:http/io_client.dart';

Future<dynamic> installApp(
  String? url,
  String? appID,
) async {
  // Add your function code here!
  print("installingApp");
  print(appID);
  print(url);

  final ioc = HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  http.Client? client = IOClient(ioc);
  http.Response response = await client.get(Uri.parse(url!));

  if (response.statusCode == 200) {
    url = url!.replaceAll("&download=1", "");

    var zipName = url.toString().split('/').last.replaceAll(".zip", "");
    print("zipName : $zipName");
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final outFile = File('${appDocumentsDir.path}/$appID.zip');
    await outFile.writeAsBytes(response.bodyBytes, flush: true);
    print("outFile.path : ${outFile.path}");
    //return unzipFile(outFile.path, dir, appName, url, appIcon);
    //unzip
    final bytes = File(outFile.path).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    var unzipPath = outFile.path.toString().replaceAll('$appID.zip', '');
    print("unzipPath : $unzipPath");
    var manifestData = {};
    for (final file in archive) {
      print("file : ${file.name}");
      final zipFolderName = file.name.toString().split("/")[0];
      print("zipName : $zipName");
      print("zipFolderName : $zipFolderName");
      print("appID : $appID");
      if (zipName != zipFolderName) {
        var tmpZipName = zipName.toString().split("(").last;
        print("tmpZipName $tmpZipName");
        zipName = zipName.replaceAll("($tmpZipName", "");
        print("new zipname $zipName");
      }
      final fileName = '$unzipPath/${file.name.replaceAll(zipName, appID!)}';
      if (file.isFile && !fileName.contains("__MACOSX")) {
        print("fileName : $fileName");
        final outFile = File(fileName);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);

        if (RegExp(r'manifest\.json$').hasMatch(fileName)) {
          final file = File(fileName);
          final contents = await file.readAsString();
          final data = jsonDecode(contents);
          manifestData = data;
        }
      }
    }
    var newPath = outFile.path.toString().replaceAll('.zip', '');
    print("newPath");
    print(newPath);
    manifestData["msg"] = "success";
    manifestData["status"] = "success";
    manifestData["path"] = '$newPath/index.html';
    print("manifestData");
    print(manifestData);
    print(manifestData["path"]);
    return manifestData;
  } else {
    return {"msg": '${response.statusCode}', "status": "failed"};
  }
}
