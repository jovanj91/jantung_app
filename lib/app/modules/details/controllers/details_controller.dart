import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:video_player/video_player.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController

  PatientService? patient;
  PreprocessingService? preprocessing;

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
  RxBool isVideoUploading = false.obs;
  Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<FilePickerResult?> video = Rx<FilePickerResult?>(null);
  Rx<List<Map<String, dynamic>>> fileList = Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() async {
    this.patient = Get.find<PatientService>();
    this.preprocessing = Get.find<PreprocessingService>();

    super.onInit();
    listHistory.clear();

    // Fetch Data
    getPatientHistory();
  }

  getImage(gender) {
    if (gender == 0) {
      return "assets/images/man.png";
    } else {
      return "assets/images/woman.png";
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
          refreshHistory();
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
  Future<void> refreshHistory() async {
    page = 1;
    listHistory.clear();
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

  var isButtonDisabled = false.obs;

  detectEchocardiography() async {
    try {
      if (!isButtonDisabled.value) {
        isButtonDisabled(true);
        isVideoUploading(true);
        await this
            .preprocessing
            ?.detectEchocardiography(selectedVideo.value!,
                this.patient?.patientHistory.value.patientId)
            .then((response) {
          print(response);
          if (VerifyError.verify(response)) {
            Get.snackbar('Failed, retrying', response.getError(),
                snackPosition: SnackPosition.TOP);
          } else {
            isVideoUploading(false);
            isButtonDisabled(false);
            Get.back();
            Get.snackbar('File Uploaded', 'Heart Checked Successfully',
                snackPosition: SnackPosition.TOP);
          }
        }, onError: (err) {
          Get.snackbar('Heart Check Failed ', err.toString(),
              snackPosition: SnackPosition.TOP);
        });
      }
    } catch (e) {
      Get.snackbar('Heart Check Failed', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  uploadVideo() async {
    try {
      await this.preprocessing?.processVideo(selectedVideo.value!).then(
          (response) {
        print(response);
        if (VerifyError.verify(response)) {
          Get.snackbar('Failed, try again', response.getError(),
              snackPosition: SnackPosition.TOP);
        } else {
          Get.back();
          Get.snackbar('File Uploaded', 'Patient Added Successfully',
              snackPosition: SnackPosition.TOP);
        }
      }, onError: (err) {
        Get.snackbar('Failed add Patient', err.toString(),
            snackPosition: SnackPosition.TOP);
      });
    } catch (e) {
      Get.snackbar('Failed add Patient', e.toString(),
          snackPosition: SnackPosition.TOP);
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
