import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestUtils {
  static Future createMockDioResponse(
    String json,
    int httpStatus, {
    RequestOptions? requestOptions,
  }) async {
    return Response(
      data: jsonDecode(json),
      statusCode: httpStatus,
      requestOptions: requestOptions ?? RequestOptions(path: ':path'),
    );
  }

  static Widget buildBaseTestableWidget({
    required Widget widget,
  }) =>
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      );
}
