import 'package:dio/dio.dart';

class ListTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return options.data;
  }
}
