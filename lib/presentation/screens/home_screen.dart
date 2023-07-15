import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_compressor/domain/entities/fetch_state.dart';
import 'package:whatsapp_compressor/presentation/provider/pick_video_provider.dart';
import 'package:whatsapp_compressor/presentation/widgets/pick_video_builder.dart';

import '../../i18n/i18n.dart';
import '../provider/compress_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoPickerProvider);
    final compressState = ref.watch(compressProvider);

    return WillPopScope(
      onWillPop: () async {
        if (state is FetchLoaded && compressState is! FetchLoading) {
          ref.read(videoPickerProvider.notifier).setNull();
          return false;
        }

        if (compressState is FetchLoading) {
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizationInstance.videoCompressor),
          centerTitle: true,
          leading: state is FetchLoaded && compressState is! FetchLoading
              ? IconButton(
                  onPressed: () {
                    ref.read(videoPickerProvider.notifier).setNull();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))
              : null,
        ),
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: PickVideoBuilder()),
        ),
      ),
    );
  }
}
