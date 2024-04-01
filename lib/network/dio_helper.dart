import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio dio=Dio(BaseOptions(baseUrl: 'https://second2hand.pythonanywhere.com/api/v1/',
  receiveDataWhenStatusError: true),);
  static init() {

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

static Future<Response> getData({required String path, query,
  String lang='en',String? token}) async
 {
   dio.options.headers= {
     'lang':lang,
     'Authorization':token,
     'Content-Type': 'application/json'
   };
    return await dio.get(path,queryParameters: query);
  }

  static Future<Response> postData({required String path, Map <String,dynamic>?query,
    @required data,String lang='en',String? token})async{

    dio.options.headers= {
      'lang':lang,
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    return await dio.post(path,queryParameters: query,data:data );
  }

  static Future<Response> putData({required String path, Map <String,dynamic>? query,
    @required data,String lang='en',String? token})async{

    dio.options.headers= {
      'lang':lang,
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    return await dio.put(path,queryParameters: query,data:data );
  }
}