import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/modules/details/controllers/details_controller.dart';
import 'package:jantung_app/core/utils/size_config.dart';
import 'package:video_player/video_player.dart';

class HeartCheckForm extends StatelessWidget {
  final controller = Get.find<DetailsController>();

  HeartCheckForm({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Obx(() {
          if (controller.video.value != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected File:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(controller.video.value?.files[0].name ?? '',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))
                ],
              ),
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: controller.processVideo,
                child: const Text("Select Video"),
              ),
            );
          }
        }),
        SizedBox(height: 20),
      ],
    );
  }
}
