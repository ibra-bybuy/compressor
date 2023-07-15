import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whatsapp_compressor/domain/entities/errors_state.dart';

abstract class VideoPickerRepository {
  Future<Either<ErrorState, File>> pickVideo();
}
