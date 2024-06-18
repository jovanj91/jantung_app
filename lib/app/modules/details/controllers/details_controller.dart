import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';
import 'package:jantung_app/app/modules/details/views/trimmer_view.dart';
import 'package:jantung_app/core/utils/get_errors.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';
// ignore: unused_import
import 'package:android_intent_plus/flag.dart';

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

  final Trimmer _trimmer = Trimmer();
  final RxDouble startValue = 0.0.obs;
  final RxDouble endValue = 0.0.obs;
  final RxBool isPlaying = false.obs;
  final RxBool progressVisibility = false.obs;
  var trimmedVideoPath = ''.obs;

  Trimmer get trimmer => _trimmer;

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

  Future<void> clearVideo() async {
    selectedVideo = Rx<File?>(null);
    video = Rx<FilePickerResult?>(null);
    fileList = Rx<List<Map<String, dynamic>>>([]);
    startValue.value = 0.0;
    endValue.value = 0.0;
    isPlaying.value = false;
    progressVisibility.value = false;
    trimmedVideoPath.value = '';
    _trimmer.dispose();
  }

  void _sendBroadcast() {
    const intent = AndroidIntent(
      action: 'com.example.broadcast',
    );
    intent.launch();
  }

  Future<void> openEchoApp() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.sonostar.wirelessusg';
    // const intent = AndroidIntent(action: 'action_view', package: '');
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.sonostar.wirelessusg');

    if (isInstalled) {
      print('executed');
      DeviceApps.openApp('com.sonostar.wirelessusg');
      // intent.launch();
    } else {
      Get.snackbar('Not installed', 'Wireless USG not installed');
      await launchUrl(Uri.parse(url));
    }
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

  Future<void> newestVideo() async {
    try {
      final videoDirPath = Directory('/storage/emulated/0/Movies');
      print(videoDirPath);
      if (!videoDirPath.existsSync()) {
        return null;
      }
      final files = videoDirPath.listSync().whereType<File>().toList();

      final videoFiles = files
          .where((file) => file.path.endsWith('.mp4'))
          .toList()
        ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      // ignore: unnecessary_null_comparison
      if (videoFiles != null) {
        selectedVideo.value = videoFiles.first;
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
            detectEchocardiography();
          } else {
            isVideoUploading(false);
            isButtonDisabled(false);
            Get.back();
            Get.snackbar('File Uploaded', 'Heart Checked Successfully',
                snackPosition: SnackPosition.TOP);
            refreshHistory();
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

  trimVideo() async {
    await Get.to(() => TrimmerView(selectedVideo.value!));
  }

  void loadVideo(File videoFile) {
    _trimmer.loadVideo(videoFile: videoFile);
  }

  void setTrimmedVideoPath(String path) {
    trimmedVideoPath.value = path;
  }

  void saveVideo() {
    progressVisibility.value = true;
    _trimmer.saveTrimmedVideo(
      startValue: startValue.value,
      endValue: endValue.value,
      onSave: (outputPath) {
        progressVisibility.value = false;
        setTrimmedVideoPath(outputPath!);
        final snackBar = SnackBar(
          content: Text('Video Saved successfully\n$outputPath'),
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        // videoPlayerController = VideoPlayerController.file(File(outputPath));
        // // Initialize the video player controller
        // await videoPlayerController.initialize();
        // update();
        Get.back();
      },
    );
  }

  Future<bool> videoPlaybackControl() async {
    final playbackState = await _trimmer.videoPlaybackControl(
      startValue: startValue.value,
      endValue: endValue.value,
    );
    isPlaying.value = playbackState;
    return playbackState;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _trimmer.dispose();
    super.onClose();
  }
}
