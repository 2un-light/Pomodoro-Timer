import 'package:flutter/material.dart';
import 'package:pomodoro_timer/model/animation_asset_resolver_model.dart';
import 'package:video_player/video_player.dart';

class BaseSessionAnimation extends StatefulWidget {
  final double width;
  final double height;
  final bool isRunning;
  final String themeName;
  final String sessionType;

  const BaseSessionAnimation({
    super.key,
    required this.width,
    required this.height,
    required this.isRunning,
    required this.themeName,
    required this.sessionType,
  });

  @override
  State<BaseSessionAnimation> createState() => _BaseSessionAnimationState();
}

class _BaseSessionAnimationState extends State<BaseSessionAnimation> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeControllerForTheme();
  }

  Future<void> _initializeControllerForTheme() async {
      final videoPath = AnimationAssetResolver.getVideoPath(
          themeName: widget.themeName,
          sessionType: widget.sessionType
      );

    _controller = VideoPlayerController.asset(videoPath, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) {
        if(!mounted) return;
        if (widget.isRunning) {
          _controller.play();
        }
        setState(() {});
      });
      print(videoPath);
  }

  @override
  void didUpdateWidget(covariant BaseSessionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRunning != oldWidget.isRunning) {
      widget.isRunning ? _controller.play() : _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox();
    }

    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Transform.rotate(
          angle: 0,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        )
    );
  }
}