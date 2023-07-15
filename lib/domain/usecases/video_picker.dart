import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/errors_state.dart';
import '../repositories/video_picker_rep.dart';

final videoPickerUsecaseProvider = Provider<VideoPickerRepository>(
  (ref) {
    return VideoPickerUsecase();
  },
);

class VideoPickerUsecase implements VideoPickerRepository {
  final _picker = ImagePicker();

  @override
  Future<Either<ErrorState, File>> pickVideo() async {
    final video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      return Right(File(video.path));
    }

    return const Left(FileNotChosen(""));
  }
}
