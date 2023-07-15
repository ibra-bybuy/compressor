import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/repositories/video_picker_rep.dart';
import 'package:whatsapp_compressor/domain/usecases/video_picker.dart';

import '../../domain/entities/fetch_state.dart';

final videoPickerProvider =
    StateNotifierProvider<VideoPicker, FetchState<File>>(
  (ref) {
    final repository = ref.watch(videoPickerUsecaseProvider);
    return VideoPicker(
      ref,
      repository,
    );
  },
);

class VideoPicker extends StateNotifier<FetchState<File>> {
  final Ref ref;
  final VideoPickerRepository repository;
  VideoPicker(this.ref, this.repository) : super(FetchInitial());

  void setNull() {
    state = FetchInitial();
  }

  Future<void> pick() async {
    state = const FetchLoading();

    final response = await repository.pickVideo();

    response.fold((l) {
      state = FetchError(l);
    }, (r) {
      state = FetchLoaded(r);
    });
  }
}
