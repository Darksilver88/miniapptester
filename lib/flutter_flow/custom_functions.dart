import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

int getAppIndex(
  String appID,
  List<dynamic> dataList,
) {
  return dataList.indexWhere((item) => item["app_id"] == appID);
}

dynamic isTrue() {
  return true;
}

dynamic isOne(int number) {
  return (number == 1) ? true : false;
}
