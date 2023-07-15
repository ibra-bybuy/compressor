import 'package:equatable/equatable.dart';

import 'errors_state.dart';

abstract class FetchState<T> extends Equatable {
  const FetchState();

  @override
  List<Object?> get props => [];
}

class FetchInitial<T> extends FetchState<T> {}

class FetchLoading<T> extends FetchState<T> {
  final T? response;
  const FetchLoading({this.response});

  @override
  List<Object?> get props => [response];
}

class FetchLoaded<T> extends FetchState<T> {
  final T response;
  const FetchLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class FetchError<T> extends FetchState<T> {
  final ErrorState response;
  const FetchError(this.response);

  @override
  List<Object?> get props => [response];
}
