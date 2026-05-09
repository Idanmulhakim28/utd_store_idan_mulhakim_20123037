import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com")) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<dynamic> get(String endpoint) async {
    final response = await dio.get(endpoint);
    return response.data;
  }
}
