import 'dart:convert';

import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class AppDioClient implements IAppHttpClient {
  late final Dio _dio;
  final publicKey = const String.fromEnvironment(
    'PUBLIC_KEY',
    defaultValue: '',
  );
  final privateKey = const String.fromEnvironment(
    'PRIVATE_KEY',
    defaultValue: '',
  );

  AppDioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: 'http://gateway.marvel.com',
      connectTimeout: 1000,
      receiveTimeout: 1000,
    );
  }

  String _prepareEndPoint(String endPoint) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = md5
        .convert(
          utf8.encode('$timestamp$privateKey$publicKey'),
        )
        .toString();
    if (endPoint.contains('limit') || endPoint.contains('offset')) {
      return '$endPoint&ts=$timestamp&apikey=$publicKey&hash=$hash';
    }
    return '$endPoint?ts=$timestamp&apikey=$publicKey&hash=$hash';
  }

  @override
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.get(
      _prepareEndPoint(url),
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future post(
    String url, {
    Map? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.post(
      _prepareEndPoint(url),
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future put(String url,
      {Map? body,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) {
    return _dio.put(
      _prepareEndPoint(url),
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.delete(
      _prepareEndPoint(url),
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future patch(
    String url, {
    Map? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _dio.patch(
      _prepareEndPoint(url),
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }
}
