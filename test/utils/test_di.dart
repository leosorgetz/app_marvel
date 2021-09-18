import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_cubit.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_cubit.dart';
import 'package:get_it/get_it.dart';

import 'mocks.dart';

final getIt = GetIt.instance;

class TestDI {
  static void setUpTestDi() {
    getIt.registerLazySingleton<IGetCharactersUseCase>(
      () => MockGetCharactersUseCase(),
    );
    getIt.registerLazySingleton<IGetComicsUseCase>(
      () => MockGetComicsUseCase(),
    );
    getIt.registerLazySingleton(
      () => ListCharactersCubit(getIt<IGetCharactersUseCase>()),
    );
    getIt.registerLazySingleton(
      () => DetailCharacterCubit(getIt<IGetComicsUseCase>()),
    );
  }
}
