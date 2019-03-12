import 'package:fimber/fimber.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_project/const.dart';
import 'package:flutter_base_project/data/auth_repository.dart';

class AuthHeaderEndpoint {
  final AuthRepository _authRepository;
  final Dio dio;

  AuthHeaderEndpoint(this._authRepository, this.dio) {
    dio.options.baseUrl = API_URL;
    dio.options.connectTimeout = 5000;

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: authHeaderHandler,
        onResponse: onResponse,
        onError: fimberErrorHandler));
  }

  authHeaderHandler(RequestOptions options) async {
    var token = await _authRepository.getToken();
    options.headers = {'Authorization': 'Bearer $token'};
    Fimber.w('Bearer $token');
    options.followRedirects = false;
    Fimber.d("$options");
  }

  onResponse(Response response) async {
    Fimber.d("$response");
  }

  fimberErrorHandler(DioError e) async {
    switch (e.type) {
      case DioErrorType.CANCEL:
        Fimber.w("Request cancelled [${e.request}]");
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        Fimber.e("Request timeout [${e.request}]");
        break;
      case DioErrorType.DEFAULT:
        Fimber.e("Default error [${e.request}]",
            ex: e.error, stacktrace: e.stackTrace);
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        Fimber.e("Recieve timeout [${e.request}]",
            ex: e.error, stacktrace: e.stackTrace);
        break;
      case DioErrorType.RESPONSE:
        Fimber.e("Response [${e.response}]",
            ex: e.error, stacktrace: e.stackTrace);
        if (e.response.statusCode == 401) {
          var token = await this._authRepository.refreshToken();
          if (e.request == null) return;
          if (e.request.headers == null)
            e.request.headers = {'Autorization': 'Bearer $token'};
          else
            e.request.headers['Authorization'] = "Bearer $token";
          dio.resolve(e.request);
        }
        break;
    }

    Fimber.d("$e");
    Fimber.e(e.message, ex: e.error);
  }
}
