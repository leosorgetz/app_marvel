import 'package:app_marvel/src/core/models/character_model.dart';
import 'package:app_marvel/src/core/use_cases/get_characters_use_case.dart';
import 'package:app_marvel/src/ui/shared/states/base_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCharactersCubit extends Cubit<BaseState> {
  final IGetCharactersUseCase _getCharactersUseCase;
  var limit = 20;
  var offset = 0;
  final characters = <CharacterModel>[];

  ListCharactersCubit(this._getCharactersUseCase) : super(const EmptyState());

  Future<void> getCharacters() async {
    if (characters.isEmpty) {
      emit(const LoadingState());
    }
    final result = await _getCharactersUseCase(
      limit: limit,
      offset: offset,
    );
    if (result.isSuccess) {
      characters.addAll(result.getSuccessData);
      emit(SuccessState(result.getSuccessData));
    } else {
      emit(ErrorState(result.getErrorData.message));
    }
  }
}
