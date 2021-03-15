import 'dart:convert';
import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../utils/dio_util.dart';

Future categoryGetList({params}) async {
  return DioUtil.request(
      url: servicePath['category']['list'], method: "GET", queryParams: params);
}

Future categoryListMget({data}) async {
  return DioUtil.request(
      url: servicePath['category']['mget'],
      data: jsonEncode(data),
      method: "POST");
}
