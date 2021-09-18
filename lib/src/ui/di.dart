import 'package:app_marvel/config/di/di_interface.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_cubit.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_cubit.dart';
import 'package:get_it/get_it.dart';

class UiDependencies implements DIInterface {
  GetIt getIt;

  UiDependencies(this.getIt);

  @override
  void initDependencies() {
    getIt.registerLazySingleton(
      () => ListCharactersCubit(getIt<IGetCharactersUseCase>()),
    );
    getIt.registerLazySingleton(
      () => DetailCharacterCubit(getIt<IGetComicsUseCase>()),
    );
  }
}
