import 'dart:convert';

import 'package:http/http.dart' as http;

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