import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:incidence_front/models/Agence.dart';
import 'package:incidence_front/models/Incident.dart';
import 'package:incidence_front/models/Inscription.dart';
import 'package:incidence_front/models/Type.dart'  ;

class AppDio {
  static Dio dio = Dio();
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: "http://192.168.0.144:8000/",
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json"
        },
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
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ));
  }

  static Future<Response> createDocument({
    required String url,
    required FormData info,
    required String token,
  }) async {
    return await dio.post(url,
        data: info,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ));
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

  static Future<Response> getData({
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

  static Future<List<Type>> getAllType({
    required String url,
    required String token,
  })async {
    try{
      var response=await dio.get(url,  options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
      return typeFromJson(jsonEncode(response.data));
    }catch(error){
       print(error);
      throw Exception();
    }
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
  static Future<List<Incident>>getAllIncidenct({
    required String url,
    required String token,
  })async{
    try{
      var response=await dio.get(url,  options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
      return incidentFromJson(jsonEncode(response.data));
    }catch(error){
       print(error);
      throw Exception();
    }
    
  }
  


}
