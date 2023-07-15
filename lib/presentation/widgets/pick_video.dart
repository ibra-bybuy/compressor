import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/i18n.dart';
import '../provider/compress_provider.dart';
import '../provider/pick_video_provider.dart';

class PickVideo extends ConsumerWidget {
  const PickVideo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.invalidate(compressProvider);
        ref.read(videoPickerProvider.notifier).pick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.collections_bookmark,
            size: 70.0,
          ),
          const SizedBox(height: 30.0),
          Text(
            localizationInstance.chooseVideo,
            style: const TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}
