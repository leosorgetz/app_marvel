import 'package:app_marvel/src/core/errors/base_error.dart';

class Result<Success> {
  Success? _success;
  BaseError? _error;

  Result(Object object) {
    if (object is Success) {
      _success = object as Success;
    } else {
      _error = object as BaseError;
    }
  }

  bool get isSuccess => _success != null;

  bool get isError => _success != null;

  Success get getSuccessData => _success!;

  BaseError get getErrorData => _error!;
}

class ResultSuccess<S> extends Result<S> {
  @override
  final S _success;

  ResultSuccess(this._success) : super(_success!);
}

class ResultError<E> extends Result<E> {
  @override
  final BaseError _error;

  ResultError(this._error) : super(_error);
}
