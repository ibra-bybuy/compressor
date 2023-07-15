import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/repositories/compress_rep.dart';

import '../../data/source/compressor/compressor.dart';

final compressUsecaseProvider = Provider<CompressUsecase>(
  (ref) {
    final rep = ref.read(compressLibProvider);
    return CompressUsecase(rep);
  },
);

class CompressUsecase implements CompressRepository {
  final CompressRepository repository;
  const CompressUsecase(this.repository);

  @override
  Future<bool> compress(
    String path, {
    void Function(double progress)? listen,
    void Function(String path)? onSuccess,
    void Function(String message)? onFailure,
  }) {
    return repository.compress(path,
        listen: listen, onFailure: onFailure, onSuccess: onSuccess);
  }
}
