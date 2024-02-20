import 'dart:developer';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:get/get.dart';
import '../cache_stroage/localStroage.dart';
import 'ConnectivityRequestRetrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectiveRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      // if(err.error is SocketException.)
      final ConnectivityResult connectivity =
          await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        handler.reject(err);
        return;
      }
      log("Solved : ${err.error is SocketException} ${connectivity}");
      DIO.Response response = await requestRetrier.scheduleRequestRetry(err);

      handler.resolve(response);
    } else {
      log("message : No Network Error ${err.type == DioErrorType.connectionError}");
      log("message : ${err.error.toString()} ${err.type == DioErrorType.connectionError}");

      if (err.response != null && err.response!.statusCode == 401) {
        return;
      }
      if (err.response == null) {
        return;
      } else {
        if (err.response!.data.runtimeType == String) {
          return;
        } else {
          if (err.response!.statusCode == 404) {
            log("message : ${err.response}");
            Map<String, dynamic> messageRes = err.response!.data;
            log("Message ; ${messageRes["message"]}");
            dynamic message =
                (messageRes['message'] ?? "Error Happened").toString();
            return;
          }
          Map<String, dynamic> messageRes = err.response!.data;
          String message = messageRes['message'] ?? "Error Happened";
          return;
        }
      }
    }
    // if(err.response!.statusCode==301)
    handler.next(err);
    super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectionError ||
        err.error is SocketException;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorage.getJWT();
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}
