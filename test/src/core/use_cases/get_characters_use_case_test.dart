import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/repositories/get_characters_repository.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  late IGetCharactersRepository repositoryMock;
  late IGetCharactersUseCase useCase;
  final characters = <CharacterModel>[
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall: 'imageSmall',
      imageLarge: 'imageLarge',
      imageMedium: 'imageMedium',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall: 'imageSmall',
      imageLarge: 'imageLarge',
      imageMedium: 'imageMedium',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall: 'imageSmall',
      imageLarge: 'imageLarge',
      imageMedium: 'imageMedium',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall: 'imageSmall',
      imageLarge: 'imageLarge',
      imageMedium: 'imageMedium',
    ),
  ];

  const limit = 1;
  const offset = 1;

  setUpAll(() async {
    registerFallbackValue(limit);
    registerFallbackValue(offset);
    repositoryMock = MockGetCharactersRepository();
    useCase = GetCharactersUseCase(repositoryMock);
  });

  group('Get Characters Use Case Tests', () {
    test('[Use Case] - Should be return list of characters', () async {
      when(() => repositoryMock(
            limit: limit,
            offset: offset,
          )).thenAnswer(
        (_) async => ResultSuccess(characters),
      );
      final result = await useCase(
        limit: limit,
        offset: offset,
      );
      expect(result.isSuccess, true);
      expect(result, isA<ResultSuccess<List<CharacterModel>>>());
    });

    test('[Use Case] - Should be return error on get list of characters',
        () async {
      const error = ':error';
      when(() => repositoryMock(
            limit: limit,
            offset: offset,
          )).thenAnswer(
        (_) async => ResultError(AppError(error)),
      );
      final result = await useCase(
        limit: limit,
        offset: offset,
      );
      expect(result, isA<ResultError>());
      expect(result.isSuccess, false);
      expect(result.getErrorData, isA<AppError>());
      expect(result.getErrorData.message, error);
    });
  });
}
