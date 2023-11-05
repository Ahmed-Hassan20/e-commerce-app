import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/api/ApiConstants.dart';
import 'package:e_commerce/data/model/request/LoginRequest.dart';
import 'package:e_commerce/data/model/request/RegisterRequest.dart';
import 'package:e_commerce/data/model/response/LoginResponseDto.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:http/http.dart' as http;
import '../model/response/RegisterResponseDto.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<Either<Failures, RegisterResponseDto>> register(String name,
      String email, String password, String rePassword, String phone) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.http(ApiConstants.baseUrl, ApiConstants.registerApi);
      var requestBody = RegisterRequest(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      );
      var response = await http.post(url, body: requestBody.toJson());
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var registerResponse = RegisterResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(registerResponse);
      } else {
        return Left(Failures(
            errorMessage: registerResponse.error != null
                ? registerResponse.error!.msg
                : registerResponse.message));
      }
    } else {
      return Left(Failures(errorMessage: 'Check internet connection'));
    }
  }

  Future<Either<Failures, LoginResponseDto>> login(String email, String password) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.http(ApiConstants.baseUrl, ApiConstants.loginApi);
      var requestBody = LoginRequest(
        email: email,
        password: password,
      );
      var response = await http.post(url, body: requestBody.toJson());
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var LoginResponse = LoginResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(LoginResponse);
      } else {
        return Left(Failures(
            errorMessage: LoginResponse.message));
      }
    } else {
      return Left(Failures(errorMessage: 'Check internet connection'));
    }
  }
}
