import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_demo/utils/dio_list_transformer.dart';
import 'dart:async';
import 'dart:io';
import '../config//http_headers.dart';
import '../config/service_url.dart';
import 'package:dio_log/dio_log.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

Function onRequest(RequestOptions options) {
  int _code = Random(10).nextInt(1000);
  print(
      "\n================================= Request Data Start $_code=================================");
  print("method = ${options.method.toString()}");
  print("url = ${options.uri.toString()}");
  print("headers = ${options.headers}");
  print("params = ${options.queryParameters}");
  print("data = ${options.data}");
  print(
      "\n================================= Request Data End $_code=================================");
}

Function onResponse(Response response) {
  int _code = Random(10).nextInt(1000);
  print(
      "\n================================= Response Data Start $_code =================================");
  print("code = ${response.statusCode}");
  print("data = ${response.data}");
  print(
      "================================= Response Data End $_code =================================\n");
}

Function onError(DioError e) {
  print(
      "\n================================= Error Response =================================");
  print("type = ${e.type}");
  print(e.response);
  print("message = ${e.message}");
  print("\n");
}

class DioUtil {
  static Dio dio = new Dio();
  static CookieJar cookieJar = CookieJar();
  static Future request({url, method, data, queryParams}) async {
    // Cookie
    dio.interceptors.add(CookieManager(cookieJar));
    print(cookieJar);
    // Logger
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: onRequest, onResponse: onResponse, onError: onError));
    try {
      Response response;
      dio.options.headers = CUSTOM_HTTP_HEADERS;
      Options _options = new Options(method: method);
      response = await dio.request(
        SERVICE_BASE_URL + url,
        data: data,
        options: _options,
        queryParameters: queryParams,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("API ERROR: ${url}");
      }
    } catch (e) {
      print(e);
    }
  }
}
