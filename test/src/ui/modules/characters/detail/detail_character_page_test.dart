import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/models/comic_model.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_cubit.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/test_di.dart';
import '../../../../../utils/test_utils.dart';

void main() {
  late IGetComicsUseCase useCase;
  late DetailCharacterCubit detailCharacterCubit;
  final character = CharacterModel(
    id: 'id',
    name: 'name',
    description: 'description',
    imageSmall:
        'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    imageLarge:
        'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    imageMedium:
        'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
  );
  final comics = <ComicModel>[
    ComicModel(
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    ComicModel(
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    ComicModel(
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    ComicModel(
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    ComicModel(
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
  ];

  setUpAll(() async {
    TestDI.setUpTestDi();
    useCase = getIt<IGetComicsUseCase>();
    detailCharacterCubit = getIt<DetailCharacterCubit>();
  });

  testWidgets('[Success List Characters Page Test]',
      (WidgetTester tester) async {
    when(() => useCase(any())).thenAnswer(
      (_) async => ResultSuccess(comics),
    );
    await tester.pumpWidget(
      TestUtils.buildBaseTestableWidget(
        widget: DetailCharacterPage(character: character),
      ),
    );
    await tester.pump();
    expect(find.text(character.name), findsNWidgets(1));
    expect(find.text(character.description), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(3));
  });

  testWidgets('[Error List Characters Page Test]', (WidgetTester tester) async {
    const error = ':error';
    when(() => useCase(any())).thenAnswer(
      (_) async => ResultError(AppError(error)),
    );
    await tester.pumpWidget(
      TestUtils.buildBaseTestableWidget(
        widget: DetailCharacterPage(character: character),
      ),
    );
    await tester.pump();
    expect(find.text(error), findsOneWidget);
  });
}
