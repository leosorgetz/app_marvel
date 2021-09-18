import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/repositories/get_characters_repository.dart';
import 'package:app_marvel/src/core/shared/result_wrapper/result_wrapper.dart';

abstract class IGetCharactersUseCase {
  Future<Result<List<CharacterModel>>> call({int limit = 10, int offset = 0});
}

class GetCharactersUseCase implements IGetCharactersUseCase {
  final IGetCharactersRepository _repository;

  GetCharactersUseCase(this._repository);

  @override
  Future<Result<List<CharacterModel>>> call({
    int limit = 15,
    int offset = 0,
  }) async {
    return _repository(
      limit: limit,
      offset: offset,
    );
  }
}
