import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/details/controllers/details_controller.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimmerView extends StatelessWidget {
  final DetailsController controller = Get.put(DetailsController());

  final File file;

  TrimmerView(this.file, {Key? key}) : super(key: key) {
    controller.loadVideo(file);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).userGestureInProgress) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('Video Trimmer'),
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Obx(() => Visibility(
                        visible: controller.progressVisibility.value,
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      )),
                  ElevatedButton(
                    onPressed: controller.progressVisibility.value
                        ? null
                        : () async {
                            controller.saveVideo;
                          },
                    child: const Text('SAVE'),
                  ),
                  Expanded(child: VideoViewer(trimmer: controller.trimmer)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TrimViewer(
                        trimmer: controller.trimmer,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery.of(context).size.width,
                        durationStyle: DurationStyle.FORMAT_MM_SS,
                        maxVideoLength: Duration(
                          seconds: controller.trimmer.videoPlayerController!
                              .value.duration.inSeconds,
                        ),
                        editorProperties: TrimEditorProperties(
                          borderPaintColor: Colors.yellow,
                          borderWidth: 4,
                          borderRadius: 5,
                          circlePaintColor: Colors.yellow.shade800,
                        ),
                        areaProperties:
                            TrimAreaProperties.edgeBlur(thumbnailQuality: 10),
                        onChangeStart: (value) =>
                            controller.startValue.value = value,
                        onChangeEnd: (value) =>
                            controller.endValue.value = value,
                        onChangePlaybackState: (value) =>
                            controller.isPlaying.value = value,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Obx(() => controller.isPlaying.value
                        ? const Icon(
                            Icons.pause,
                            size: 80.0,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 80.0,
                            color: Colors.white,
                          )),
                    onPressed: () async {
                      final playbackState =
                          await controller.videoPlaybackControl();
                      controller.isPlaying.value = playbackState;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
