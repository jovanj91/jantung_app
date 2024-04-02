import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jantung_app/app/data/services/patient/service.dart';
import 'package:jantung_app/app/data/services/preprocessing/service.dart';
import 'package:jantung_app/core/utils/get_errors.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  PreprocessingService? preprocessing;
  PatientService? patient;

  var listPatient = List<dynamic>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  @override
  void onInit() async {
    this.patient = Get.find<PatientService>();
    super.onInit();

    // Fetch Data
    getPatient();
  }

  getImage(index) {
    if (listPatient[index]['gender'] == 0) {
      return "assets/images/doodle2.png";
    } else {
      return "assets/images/doodle3.png";
    }
  }

  // Fetch Data
  void getPatient() async {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      await patient?.getPatient().then((response) {
        if (VerifyError.verify(response)) {
          Get.snackbar('Please Reload Data', response.getError(),
              snackPosition: SnackPosition.TOP);
          refreshList();
        } else {
          isDataProcessing(false);
          listPatient.addAll(response);
          print(listPatient);
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
    getPatient();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
