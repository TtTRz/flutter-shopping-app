import 'package:dio/dio.dart';

class ListTransformxer extends DefaultTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return options.data;
  }
}
