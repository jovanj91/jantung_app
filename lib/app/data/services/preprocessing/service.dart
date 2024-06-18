import 'dart:io';

import 'package:jantung_app/app/data/provider/api.dart';
import 'package:jantung_app/app/data/services/preprocessing/repository.dart';
import 'package:get/get.dart';

class PreprocessingService extends GetxService {
  Future<PreprocessingService> init() async {
    this.repository = PreprocessingRepository(MyApi());
    return this;
  }

  PreprocessingRepository? repository;

  processVideo(File video) async {
    var data = await repository?.processVideo(video);
    print('1');
    return data;
  }

  detectEchocardiography(File video, patientId, processId) async {
    var data = await repository?.detectEchocardiography(video, patientId, processId);
    return data;
  }



}
