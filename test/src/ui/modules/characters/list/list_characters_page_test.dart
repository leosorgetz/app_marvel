import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_cubit.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../utils/test_di.dart';
import '../../../../../utils/test_utils.dart';

void main() {
  late IGetCharactersUseCase useCase;
  late ListCharactersCubit listCharactersCubit;
  final characters = <CharacterModel>[
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
      imageSmall:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageLarge:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      imageMedium:
          'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ),
    CharacterModel(
      id: 'id',
      name: 'name',
      description: 'description',
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
    useCase = getIt<IGetCharactersUseCase>();
    listCharactersCubit = getIt<ListCharactersCubit>();
    registerFallbackValue(listCharactersCubit.limit);
    registerFallbackValue(listCharactersCubit.offset);
  });

  testWidgets('[Success List Characters Page Test]',
      (WidgetTester tester) async {
    when(() => useCase(
          limit: listCharactersCubit.limit,
          offset: listCharactersCubit.offset,
        )).thenAnswer(
      (_) async => ResultSuccess(characters),
    );
    await tester.pumpWidget(
      TestUtils.buildBaseTestableWidget(
        widget: const ListCharactersPage(),
      ),
    );
    await tester.pump();
    expect(find.text('Lista de Personagens'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('[Error List Characters Page Test]', (WidgetTester tester) async {
    const error = ':error';
    when(() => useCase(
          limit: listCharactersCubit.limit,
          offset: listCharactersCubit.offset,
        )).thenAnswer(
      (_) async => ResultError(AppError(error)),
    );
    await tester.pumpWidget(
      TestUtils.buildBaseTestableWidget(
        widget: const ListCharactersPage(),
      ),
    );
    await tester.pump();
    expect(find.text(error), findsOneWidget);
  });
}
