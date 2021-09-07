import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class Api {
  static String baseUrl = '';
  Dio _dio;
  var options;

  /// Add Authorization header
  /*set authToken(String token) {
    _authToken = token;
    if (_authToken != null && token.isNotEmpty) {
      _dio.options.headers = <String, dynamic>{
        "Content-Type": 'application/json',
        "Authorization": _authToken,
      };
    }
  }*/

  // Getters for API end-points
  static String get getShopList =>
      'https://team-edith.glitch.me/customer/listPackages?patientId=91914';
  static String get sendBooking => 'https://team-edith.glitch.me/customer/book';
  static String get getHistory =>
      'https://team-edith.glitch.me/doctor/patientDetails?patientId=91914';
  Api() {
    options = BaseOptions(
      baseUrl: baseUrl,
    );
    _dio = new Dio(options);
  }

  // ignore: non_constant_identifier_names
  Future<Response<dynamic>> GET(String path) async {
    // debugPrint(path);
    Response<dynamic> response;
    try {
      response = await _dio.get(path);
      // debugPrint(response);
    } on SocketException catch (e) {
      print("Socket exception:");
      print(e);
    } on DioError catch (e) {
      print("DioError");
      print(e);
      print(e.response);
      if (e.type == DioErrorType.response) {
        return e.response;
      } else
        return null;
    } on FormatException catch (e) {
      print("Server returned an invalid response");
      print(e.message);
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  Future<Response<dynamic>> POST(String path, Map<String, dynamic> body) async {
    print(path);
    _dio.options.headers = <String, dynamic>{
      "Content-Type": 'application/json',
    };

    Response<dynamic> response;
    try {
      response = await _dio.post(path, data: body);
      // print(response);
    } on SocketException catch (e) {
      print(e);
    } on DioError catch (e) {
      print(e);
      if (e != null && e.type == DioErrorType.response) {
        return e.response;
      } else
        return null;
    } on FormatException catch (e) {
      print("Server returned an invalid response");
      print(e.message);
    }
    return response;
  }

  // ignore: non_constant_identifier_names
  Future<Response<dynamic>> PUT(String path, Map<String, dynamic> body) async {
    print(path);
    Response<dynamic> response;

    try {
      response = await _dio.put(path, data: body);
      print(response);
    } on SocketException catch (e) {
      print("Socket exception:");
      print(e);
    } on DioError catch (e) {
      print("DioError:");
      print(e);
      if (e != null && e.type == DioErrorType.response) {
        print(e.type);
        return e.response;
      } else
        return null;
    } on FormatException catch (e) {
      print("Server returned an invalid response");
      print(e.message);
    }
    return response;
  }
}
