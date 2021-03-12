import 'dart:convert';

import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../utils/dio_util.dart';

Future userRegister(data) async {
  return DioUtil.request(
    url: servicePath['user']['register'],
    data: jsonEncode(data),
    method: "GET",
  );
}

// web_login
Future userWebLogin(Map<String, dynamic> data) async {
  return DioUtil.request(
    url: servicePath['user']['web_login'],
    data: jsonEncode(data),
    method: "POST",
  );
}
