import 'package:app_marvel/src/core/errors/app_errors.dart';
import 'package:app_marvel/src/core/models/comic_model.dart';
import 'package:app_marvel/src/core/shared/app_http_client/app_http_client_interface.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';

abstract class IGetComicsRepository {
  Future<Result<List<ComicModel>>> call(String characterId);
}

class GetComicsRepository implements IGetComicsRepository {
  final IAppHttpClient _appHttpClient;

  GetComicsRepository(this._appHttpClient);

  @override
  Future<Result<List<ComicModel>>> call(String characterId) async {
    try {
      final result =
          await _appHttpClient.get('/v1/public/characters/$characterId/comics');
      List<ComicModel> characterList = (result.data['data']['results'] as List)
          .map((obj) => ComicModel.fromJson(obj))
          .toList();
      return ResultSuccess(characterList);
    } catch (err) {
      return ResultError(AppError('Algo errado ocorreu.'));
    }
  }
}
