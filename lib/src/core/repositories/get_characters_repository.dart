import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';

abstract class IGetCharactersRepository {
  Future<Result<List<CharacterModel>>> call({
    required int limit,
    required int offset,
  });
}

class GetCharactersRepository implements IGetCharactersRepository {
  final IAppHttpClient _appHttpClient;

  GetCharactersRepository(this._appHttpClient);

  @override
  Future<Result<List<CharacterModel>>> call({
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await _appHttpClient.get(
        '/v1/public/characters?limit=$limit&offset=$offset',
      );
      List<CharacterModel> characterList =
          (result.data['data']['results'] as List)
              .map((obj) => CharacterModel.fromJson(obj))
              .toList();
      return ResultSuccess(characterList);
    } catch (err) {
      return ResultError(AppError('Algo errado ocorreu.'));
    }
  }
}
