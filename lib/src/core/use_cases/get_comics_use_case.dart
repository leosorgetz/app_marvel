import 'package:app_marvel/src/core/models/comic_model.dart';
import 'package:app_marvel/src/core/repositories/get_comics_repository.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';

abstract class IGetComicsUseCase {
  Future<Result<List<ComicModel>>> call(String id);
}

class GetComicsUseCase implements IGetComicsUseCase {
  final IGetComicsRepository _repository;

  GetComicsUseCase(this._repository);

  @override
  Future<Result<List<ComicModel>>> call(String characterId) {
    return _repository(characterId);
  }
}
