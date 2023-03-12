import 'package:dio/dio.dart' hide Headers;
import 'package:go_to_the_fucking_gym/api/dio_client.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/dto.dart';
import 'model/model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class _RestClient {
  factory _RestClient(Dio dio) = __RestClient;

  @GET("/workouts")
  Future<List<WorkoutRecordDto>> getWorkoutRecord(
    @Query('day') String day,
  );

  @POST('/workouts')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<HttpResponse> setWorkoutRecord(
    @Body() WorkoutRecordModel record,
  );
}

class ApiInterface {
  ApiInterface._();

  static final ApiInterface _instance = ApiInterface._();
  final _RestClient _restClient = _RestClient(DioClient().dio);

  factory ApiInterface() {
    return _instance;
  }

  Future<List<WorkoutRecordDto>> getWorkoutRecord(String day) async {
    return await _restClient.getWorkoutRecord(day);
  }

  Future<void> setWOrkoutRecord({required WorkoutRecordModel record}) async {
    await _restClient.setWorkoutRecord(record);
  }
}
