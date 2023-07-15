import 'package:equatable/equatable.dart';

abstract class ErrorState extends Equatable {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [];
}

class LoadingError extends ErrorState {
  const LoadingError(super.message);
}

class FileNotChosen extends ErrorState {
  const FileNotChosen(super.message);
}
