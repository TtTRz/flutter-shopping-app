import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo/utils/dio_list_transformer.dart';
import 'dart:async';
import 'dart:io';
import '../config//http_headers.dart';
import '../config/service_url.dart';
import 'package:dio_log/dio_log.dart';

class DioUtil {
  static Dio dio = new Dio();

  static Future request({url, method, data, queryParams}) async {
    dio.transformer = ListTransformer();
    print(data);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print(
          "\n================================= 请求数据 =================================");
      print("method = ${options.method.toString()}");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.queryParameters}");
      print("data = ${options.data}");
    }, onResponse: (Response response) {
      print(
          "\n================================= 响应数据开始 =================================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print(
          "================================= 响应数据结束 =================================\n");
    }, onError: (DioError e) {
      print(
          "\n=================================错误响应数据 =================================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("\n");
    }));
    try {
      print("${method} ${data} ${url}");
      Response response;
      dio.options.headers = CUSTOM_HTTP_HEADERS;
      Options _options = new Options(method: method);
      response = await dio.request(
        serviceBaseUrl + url,
        data: data,
        options: _options,
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
