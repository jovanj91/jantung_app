import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class VideoPlayerControllerResult extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void onInit() {
    super.onInit();
    // Initialize video player controller
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(Get.arguments['videoUrl']));
    // Initialize Chewie controller
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: 4 / 3, // Adjust aspect ratio as needed
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    // Dispose of video player controller and chewie controller
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}