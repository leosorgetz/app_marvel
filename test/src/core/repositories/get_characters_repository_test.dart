import 'dart:io';

import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/repositories/get_characters_repository.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';
import '../../../utils/test_utils.dart';
import 'json_results/get_characters_json_result.dart';

void main() {
  late IAppHttpClient _appHttpClient;
  late IGetCharactersRepository _repository;

  setUpAll(() async {
    _appHttpClient = MockAppHttpClient();
    _repository = GetCharactersRepository(_appHttpClient);
  });

  group('Get Characters Repository Tests', () {
    test('[Repository] - Should be return a list of characters to use case',
        () async {
      when(() => _appHttpClient.get(any())).thenAnswer(
        (_) async => TestUtils.createMockDioResponse(
          GetCharactersJsonResult.success,
          HttpStatus.ok,
        ),
      );
      final result = await _repository(limit: 10, offset: 0);
      expect(result.isSuccess, true);
      expect(result, isA<ResultSuccess<List<CharacterModel>>>());
    });

    test('[Repository] - Should be return a error to use case', () async {
      when(() => _appHttpClient.get(any())).thenAnswer(
        (_) async => TestUtils.createMockDioResponse(
          GetCharactersJsonResult.error,
          HttpStatus.badRequest,
        ),
      );
      final result = await _repository(limit: 10, offset: 0);
      expect(result.isSuccess, false);
      expect(result.getErrorData, isA<AppError>());
    });
  });
}
