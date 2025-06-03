import 'package:pistis_app/src/Common/Enums/error/error_type.dart';

sealed class Result<S, E extends ErrorType> {
  const Result();

  T fold<T>({
    required T Function(S data) onSuccess,
    required T Function(E error) onError,
  });

  bool get isError => this is Failure;
}

final class Success<S, E extends ErrorType> extends Result<S, E> {
  final S data;

  const Success(this.data);

  const Success.voidSuccess() : data = "success" as S;

  @override
  T fold<T>({
    required T Function(S data) onSuccess,
    required T Function(E error) onError,
  }) =>
      onSuccess(data);
}

final class Failure<S, E extends ErrorType> extends Result<S, E> {
  final E error;

  const Failure(this.error);

  @override
  T fold<T>({
    required T Function(S data) onSuccess,
    required T Function(E error) onError,
  }) =>
      onError(error);
}

extension ResultExtension<S, E extends ErrorType> on Result<S, E> {
  S? get data => this is Success ? (this as Success).data : null;

  ErrorType? get error => this is Failure ? (this as Failure).error : null;
}
