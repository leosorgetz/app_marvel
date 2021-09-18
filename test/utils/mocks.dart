import 'package:app_marvel/src/core/repositories/get_characters_repository.dart';
import 'package:app_marvel/src/core/repositories/get_comics_repository.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:app_marvel/src/ui/modules/characters/detail/detail_character_cubit.dart';
import 'package:app_marvel/src/ui/modules/characters/list/list_characters_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAppHttpClient extends Mock implements IAppHttpClient {}

class MockGetCharactersRepository extends Mock
    implements IGetCharactersRepository {}

class MockGetComicsRepository extends Mock implements IGetComicsRepository {}

class MockGetCharactersUseCase extends Mock implements IGetCharactersUseCase {}

class MockGetComicsUseCase extends Mock implements IGetComicsUseCase {}

class MockListCharactersCubit extends Mock implements ListCharactersCubit {}

class MockDetailCharacterCubit extends Mock implements DetailCharacterCubit {}
