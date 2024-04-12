import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:video_player/video_player.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController

  PatientService? patient;

  var listHistory = List<dynamic>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  // Video Upload
  late VideoPlayerController videoPlayerController =
      VideoPlayerController.networkUrl(Uri());
  RxBool isPlayed = false.obs;
  Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<FilePickerResult?> video = Rx<FilePickerResult?>(null);
  Rx<List<Map<String, dynamic>>> fileList = Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() async {
    this.patient = Get.find<PatientService>();
    super.onInit();

    // Fetch Data
    getPatientHistory();
  }

  getImage(gender) {
    if (gender == 0) {
      return "assets/images/doodle2.png";
    } else {
      return "assets/images/doodle3.png";
    }
  }

  // Fetch Data
  void getPatientHistory() async {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      await patient
          ?.getPatientHistory(this.patient?.patientHistory.value.patientId)
          .then((response) {
        if (VerifyError.verify(response)) {
          Get.snackbar('Trying to Reload Data', response.getError(),
              snackPosition: SnackPosition.TOP);
          refreshList();
        } else {
          isDataProcessing(false);
          listHistory.addAll(response);
          print(listHistory);
        }
      }, onError: (err) {
        isDataProcessing(false);
        Get.snackbar('Please Reload Data', err.toString(),
            snackPosition: SnackPosition.TOP);
      });
    } catch (exception) {
      isDataProcessing(false);
      Get.snackbar('Please Reload Data', exception.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  // Refresh List
  void refreshList() async {
    page = 1;
    getPatientHistory();
  }

  Future<void> processVideo() async {
    try {
      video.value = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      // ignore: unnecessary_null_comparison
      if (video != null) {
        selectedVideo.value = File(video.value!.files.single.path.toString());
        videoPlayerController =
            VideoPlayerController.file(selectedVideo.value!);
        // Initialize the video player controller
        await videoPlayerController.initialize();
        update();
      } else {
        print('User canceled file picking');
      }
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
