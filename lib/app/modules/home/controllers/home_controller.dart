import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  PreprocessingService? preprocessing;

  Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<FilePickerResult?> video = Rx<FilePickerResult?>(null);
  Rx<List<Map<String, dynamic>>> fileList = Rx<List<Map<String, dynamic>>>([]);
  var resJson = {}.obs;

  @override
  void onInit() {
    this.preprocessing = Get.find<PreprocessingService>();
    super.onInit();
    // Fetch the file list when the screen initializes
  }

  Future<void> getVideo() async {
    video.value = await FilePicker.platform.pickFiles();
    if (video.value == null) {
      print("No file selected");
    } else {
      selectedVideo.value = File(video.value!.files.single.path.toString());
      video.value?.files.forEach((element) {
        print(element.name);
      });
    }
  }

  Future<void> processVideo() async {
    var data = await preprocessing?.processVideo(selectedVideo.value!);
  }
}
