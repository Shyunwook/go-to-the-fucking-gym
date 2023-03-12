import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();

  factory DioClient() {
    return _instance;
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          'http://127.0.0.1:5001/go-to-the-fucking-gym-backend/us-central1/widgets',
    ),
  );
}
