import 'package:app_marvel/src/core/use_cases/get_comics_use_case.dart';
import 'package:app_marvel/src/ui/shared/states/base_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCharacterCubit extends Cubit<BaseState> {
  final IGetComicsUseCase _getComicsUseCase;

  DetailCharacterCubit(this._getComicsUseCase) : super(const EmptyState());

  Future<void> getCharacters(String characterId) async {
    emit(const LoadingState());
    final result = await _getComicsUseCase(characterId);
    if (result.isSuccess) {
      emit(SuccessState(result.getSuccessData));
    } else {
      emit(ErrorState(result.getErrorData.message));
    }
  }
}
