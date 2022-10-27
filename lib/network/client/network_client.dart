import 'package:dio/dio.dart';
import 'package:flyy_test_task/constants/constants.dart';

export 'package:dio/dio.dart';

class NetworkClient {
  NetworkClient._();
  Dio? _dio;

  static final NetworkClient _singleton = NetworkClient._();

  static NetworkClient getInstance() {
    return _singleton;
  }

  BaseOptions get _options {
    return BaseOptions(
      baseUrl: AppConstant.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
  }

  Dio getDio() {
    return _dio ??= Dio(_options)
      ..interceptors.addAll(
        [
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              print(options.data);
              return handler.next(options);
            },
            onResponse: (e, handler) {
              print(e.data);

              return handler.next(e);
            },
            onError: (e, handler) {
              return handler.next(e);
            },
          ),
        ],
      );
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await getDio().get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      // debugPrint(e.toString());
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await getDio().post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
