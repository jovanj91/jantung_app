import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/details/controllers/videoplayer_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends GetView<VideoPlayerController> {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 4 / 3, // Adjust aspect ratio as needed
          child: GetBuilder<VideoPlayerControllerResult>(
            init: VideoPlayerControllerResult(),
            builder: (controller) => Chewie(
              controller: controller.chewieController,
            ),
          ),
        ),
      ),
    );
  }
}