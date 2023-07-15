import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/entities/errors_state.dart';

import 'package:whatsapp_compressor/domain/usecases/compress_usecase.dart';

import '../../domain/entities/fetch_state.dart';

class CompressState {
  final double progress;
  final String path;
  const CompressState({this.progress = 0.0, this.path = ""});
}

final compressProvider =
    StateNotifierProvider<CompressNotifier, FetchState<CompressState>>(
  (ref) {
    final rep = ref.watch(compressUsecaseProvider);

    return CompressNotifier(rep, ref);
  },
);

class CompressNotifier extends StateNotifier<FetchState<CompressState>> {
  final Ref ref;
  final CompressUsecase usecase;
  CompressNotifier(
    this.usecase,
    this.ref,
  ) : super(FetchInitial());

  void compress(String path) {
    ref.read(compressProvider.notifier).state =
        const FetchLoading(response: CompressState(progress: 0));
    usecase.compress(
      path,
      listen: (progress) {
        ref.read(compressProvider.notifier).state =
            FetchLoading(response: CompressState(progress: progress));
      },
      onFailure: (str) {
        ref.read(compressProvider.notifier).state =
            FetchError(LoadingError(str));
      },
      onSuccess: (str) {
        ref.read(compressProvider.notifier).state =
            FetchLoaded(CompressState(progress: 100, path: str));
      },
    );
  }
}
