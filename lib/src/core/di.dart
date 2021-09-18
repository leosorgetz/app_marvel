import 'package:app_marvel/config/di/di_interface.dart';
import 'package:app_marvel/src/core/repositories/get_characters_repository.dart';
import 'package:app_marvel/src/core/repositories/get_comics_repository.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_dio_client.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class CoreDependencies implements DIInterface {
  GetIt getIt;

  CoreDependencies(this.getIt);

  @override
  void initDependencies() {
    getIt.registerSingleton<IAppHttpClient>(
      AppDioClient(Dio()),
    );

    // Repository
    getIt.registerFactory<IGetComicsRepository>(
      () => GetComicsRepository(getIt<IAppHttpClient>()),
    );
    getIt.registerFactory<IGetCharactersRepository>(
      () => GetCharactersRepository(getIt<IAppHttpClient>()),
    );

    // UseCase
    getIt.registerFactory<IGetComicsUseCase>(
      () => GetComicsUseCase(getIt<IGetComicsRepository>()),
    );
    getIt.registerFactory<IGetCharactersUseCase>(
      () => GetCharactersUseCase(getIt<IGetCharactersRepository>()),
    );
  }
}
