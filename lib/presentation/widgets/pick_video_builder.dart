import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/entities/fetch_state.dart';
import '../provider/pick_video_provider.dart';
import 'compress_builder.dart';
import 'pick_video.dart';

class PickVideoBuilder extends ConsumerStatefulWidget {
  const PickVideoBuilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PickVideoBuilderState();
}

class _PickVideoBuilderState extends ConsumerState<PickVideoBuilder> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoPickerProvider);

    if (state is FetchLoaded<File>) {
      return CompressBuilder(
        file: state.response,
      );
    }

    return const PickVideo();
  }
}
