import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/comic_model.dart';
import 'package:app_marvel/src/core/repositories/get_comics_repository.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  late IGetComicsRepository repositoryMock;
  late IGetComicsUseCase useCase;

  final comics = <ComicModel>[
    ComicModel(
      imageSmall: 'imageSmall',
      imageMedium: 'imageMedium',
      imageLarge: 'imageLarge',
    ),
    ComicModel(
      imageSmall: 'imageSmall',
      imageMedium: 'imageMedium',
      imageLarge: 'imageLarge',
    ),
    ComicModel(
      imageSmall: 'imageSmall',
      imageMedium: 'imageMedium',
      imageLarge: 'imageLarge',
    ),
    ComicModel(
      imageSmall: 'imageSmall',
      imageMedium: 'imageMedium',
      imageLarge: 'imageLarge',
    ),
  ];

  setUpAll(() async {
    repositoryMock = MockGetComicsRepository();
    useCase = GetComicsUseCase(repositoryMock);
  });

  group('Get Comics Use Case Tests', () {
    test('[Use Case] - Should be return list of comics', () async {
      when(() => repositoryMock(any())).thenAnswer(
        (_) async => ResultSuccess(comics),
      );
      final result = await useCase(':characterId');
      expect(result.isSuccess, true);
      expect(result, isA<ResultSuccess<List<ComicModel>>>());
    });

    test('[Use Case] - Should be return error on get list of comics', () async {
      const error = ':error';
      when(() => repositoryMock(any())).thenAnswer(
        (_) async => ResultError(AppError(error)),
      );
      final result = await useCase(':characterId');
      expect(result, isA<ResultError>());
      expect(result.isSuccess, false);
      expect(result.getErrorData, isA<AppError>());
      expect(result.getErrorData.message, error);
    });
  });
}
