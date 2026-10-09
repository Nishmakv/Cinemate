import 'dart:io';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException err, handler) async {
          final options = err.requestOptions;
          int retryCount = (options.extra['retry_count'] as int?) ?? 0;
          const maxRetries = 3;

          final isNetworkError = err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.sendTimeout ||
              err.type == DioExceptionType.connectionError ||
              (err.error != null && err.error is SocketException);

          if (isNetworkError && retryCount < maxRetries) {
            options.extra['retry_count'] = retryCount + 1;
            await Future.delayed(
                Duration(milliseconds: 600 * (retryCount + 1)));
            try {
              final response = await dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              if (e is DioException) {
                return handler.next(e);
              }
            }
          }
          return handler.next(err);
        },
      ),
    );
  }
}
