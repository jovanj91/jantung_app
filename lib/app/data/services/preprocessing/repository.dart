import 'package:jantung_app/app/data/provider/api.dart';

class PreprocessingRepository {
  final MyApi api;

  PreprocessingRepository(this.api);
  processVideo(video) => api.processVideo(video);
  detectEchocardiography(video, patientId, processId) => api.detectEchocardiography(video, patientId, processId);

}
