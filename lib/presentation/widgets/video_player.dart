import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as lib;
import 'package:whatsapp_compressor/presentation/widgets/play_btn.dart';

class VideoPlayer extends StatefulWidget {
  final String path;

  const VideoPlayer(this.path, {super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late lib.VideoPlayerController _controller;
  bool playing = false;
  bool btnHidden = false;

  @override
  void initState() {
    super.initState();
    _controller = lib.VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() {
          //_controller.play();
        });
      });

    _controller.setLooping(true);
  }

  void _start() {
    setState(() {
      playing = true;
    });

    _controller.play();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          btnHidden = true;
        });
      }
    });
  }

  void _stop() {
    setState(() {
      playing = false;
      btnHidden = false;
    });
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {
        setState(() {
          btnHidden = false;
        });
      },
      child: Center(
        child: _controller.value.isInitialized
            ? Container(
                constraints: const BoxConstraints(maxHeight: 300.0),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      lib.VideoPlayer(_controller),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: btnHidden ? 0 : 1.0,
                        child: PlayBtn(
                          play: !playing,
                          onTap: () {
                            if (playing) {
                              _stop();
                            } else {
                              _start();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
