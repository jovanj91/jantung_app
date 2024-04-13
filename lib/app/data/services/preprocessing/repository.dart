import 'package:jantung_app/app/data/provider/api.dart';

class PreprocessingRepository {
  final MyApi api;

  PreprocessingRepository(this.api);
  processVideo(video) => api.processVideo(video);
  detectEchocardiography(video, patientId) => api.detectEchocardiography(video, patientId);

}
