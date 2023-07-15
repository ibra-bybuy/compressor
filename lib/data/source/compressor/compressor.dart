import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/repositories/compress_rep.dart';
import 'package:light_compressor/light_compressor.dart';

final compressLibProvider = Provider.autoDispose<CompressRepository>(
  (ref) {
    return Compressor();
  },
);

class Compressor implements CompressRepository {
  final _lightCompressor = LightCompressor();

  @override
  Future<bool> compress(
    String path, {
    void Function(double progress)? listen,
    void Function(String path)? onSuccess,
    void Function(String message)? onFailure,
  }) async {
    _lightCompressor
        .compressVideo(
      path: path,
      videoQuality: VideoQuality.low,
      isMinBitrateCheckEnabled: false,
      video: Video(
        videoName: "Compressor ${DateTime.now().toIso8601String()}",
        keepOriginalResolution: true,
        videoBitrateInMbps: 3,
      ),
      android: AndroidConfig(
        isSharedStorage: true,
        saveAt: SaveAt.Downloads,
      ),
      ios: IOSConfig(saveInGallery: true),
    )
        .then((value) {
      if (value is OnSuccess) {
        final path = value.destinationPath;
        onSuccess?.call(path);
      }

      if (value is OnFailure) {
        onFailure?.call(value.message);
      }
    });

    _lightCompressor.onProgressUpdated.listen((event) {
      listen?.call(event);
    });

    return true;
  }
}
