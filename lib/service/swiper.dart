import 'dart:convert';
import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../utils/dio_util.dart';

Future swiperGoodsMget(data) async {
  return DioUtil.request(
      url: servicePath['swiper']['goods']['mget'],
      data: jsonEncode(data),
      method: "POST");
}
