import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:incidence_front/models/Agence.dart';
import 'package:incidence_front/models/Inscription.dart';

class AppDio {
  static Dio dio = Dio();
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: "http://192.168.1.10:8000/",
        //method: "v2/top-headlines",
      ),
    );
  }

  static Future<Response> userLogin({
    required String url,
    required Map info,
  }) async {
    return await dio.post(
      url,
      data: info,
    );
  }

  static Future<Response> register({
    required String url,
    required Map info,
  }) async {
    return await dio.post(
      url,
      data: info,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map info,
    required String token,
  }) async {
    print(token);
    return await dio.post(url,
        data: info,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  /*
  // Send Verification email
 */
  static Future<Response> sendVerificationEmail({
    required String url,
    required String token,
  }) async {
    return await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response> logout({
    required String url,
    required String token,
  }) async {
    return await dio.get(url,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Inscription> getUser({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      var response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
      return inscriptionFromJson(jsonEncode(response.data));
    } catch (error) {
      print("hada werrror");
      throw Exception();
    }
  }
}
