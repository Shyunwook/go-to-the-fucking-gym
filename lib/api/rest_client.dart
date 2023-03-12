import 'package:dio/dio.dart' hide Headers;
import 'package:go_to_the_fucking_gym/api/dio_client.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class _RestClient {
  factory _RestClient(Dio dio) = __RestClient;

  @GET("/workouts")
  Future<List<WorkoutRecordDto>> getWorkoutRecord();

  @POST('/workouts')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<HttpResponse> setWorkoutRecord(
    @Body() WorkoutRecordDto record,
  );
}

class ApiInterface {
  ApiInterface._();

  static final ApiInterface _instance = ApiInterface._();
  final _RestClient _restClient = _RestClient(DioClient().dio);

  factory ApiInterface() {
    return _instance;
  }

  Future<List<WorkoutRecordDto>> getWorkoutRecord() async {
    return await _restClient.getWorkoutRecord();
  }

  Future<void> setWOrkoutRecord({required WorkoutRecordDto record}) async {
    await _restClient.setWorkoutRecord(record);
  }
}
