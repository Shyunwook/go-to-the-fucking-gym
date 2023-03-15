import 'package:dio/dio.dart' hide Headers;
import 'package:go_to_the_fucking_gym/api/dio_client.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/dto.dart';
import 'model/model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class _RestClient {
  factory _RestClient(Dio dio) = __RestClient;

  @GET("/records")
  Future<List<WorkoutRecordDto>> getWorkoutRecords(
    @Query('day') String day,
  );

  @GET("/workouts")
  Future<List<String>> getWorkouts();

  @GET("/records/{workout}")
  Future<Map<String, WorkoutSetDto>> getRecentWorkoutRecords(
      @Path("workout") String workout);

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

  Future<List<WorkoutRecordDto>> getWorkoutRecords(String day) async {
    return await _restClient.getWorkoutRecords(day);
  }

  Future<List<String>> getWorkouts() async {
    return await _restClient.getWorkouts();
  }

  Future<Map<String, WorkoutSetDto>> getRecentWorkoutRecords(
      String workoutId) async {
    return await _restClient.getRecentWorkoutRecords(workoutId);
  }

  Future<void> setWOrkoutRecord({required WorkoutRecordModel record}) async {
    await _restClient.setWorkoutRecord(record);
  }
}
