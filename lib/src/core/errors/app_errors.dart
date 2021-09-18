import 'package:app_marvel/src/core/errors/base_error.dart';

class AppError implements BaseError {
  @override
  final String message;

  AppError(this.message);
}
