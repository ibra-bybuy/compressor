import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/components/btn/submit_btn.dart';
import '../../domain/entities/fetch_state.dart';
import '../../i18n/i18n.dart';
import '../provider/compress_provider.dart';
import '../provider/pick_video_provider.dart';
import 'video_player.dart';

class CompressBuilder extends ConsumerStatefulWidget {
  final File file;
  const CompressBuilder({super.key, required this.file});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompressBuilderState();
}

class _CompressBuilderState extends ConsumerState<CompressBuilder> {
  @override
  Widget build(BuildContext context) {
    final compressState = ref.watch(compressProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VideoPlayer(
          compressState is FetchLoaded<CompressState>
              ? compressState.response.path
              : widget.file.path,
        ),
        const SizedBox(height: 25.0),
        if (compressState is FetchInitial) ...[
          SubmitBtn(
            localizationInstance.compress,
            onPressed: () {
              ref.read(compressProvider.notifier).compress(widget.file.path);
            },
          ),
        ],
        if (compressState is FetchLoading<CompressState>) ...[
          Text(compressState.response?.progress.toInt().toString() ?? ""),
        ],
        if (compressState is FetchLoaded<CompressState>) ...[
          SubmitBtn(
            localizationInstance.share,
            backgroundColor: Colors.blue,
            onPressed: () {
              Share.shareXFiles(
                [XFile(compressState.response.path)],
              ).then((value) {
                File(compressState.response.path).delete();
              });
            },
          ),
          const SizedBox(height: 10.0),
          SubmitBtn(
            localizationInstance.finish,
            backgroundColor: Colors.red,
            onPressed: () {
              ref.read(videoPickerProvider.notifier).setNull();
            },
          ),
        ]
      ],
    );
  }
}
