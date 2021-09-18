import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {}

class LoadingState implements BaseState {
  const LoadingState();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => false;
}

class SuccessState<T> implements BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];

  @override
  bool get stringify => false;
}

class ErrorState implements BaseState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => false;
}

class EmptyState implements BaseState {
  const EmptyState();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => false;
}
