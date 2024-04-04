import 'dart:io';

import 'package:alx_spec/data_models/post_item_model.dart';
import 'package:alx_spec/network/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';

import '../shared/shared_components.dart';

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
    print (query);
    return await dio.post(path,queryParameters: query,data:data );
  }
  static Future<Response> Register({required String path, Map <String,dynamic>?query,
    @required data,String lang='en',String? token})async{
    var formData = FormData.fromMap(data);
    print (query);
    return await dio.post(path,data:formData );

    print (query);
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
  static Future<Response>PostItem_with_Image({required image,required filename,required PostItemModel model,
    @required data}) async {

      var formData = FormData.fromMap({
        'picture': await MultipartFile.fromFile(image.path,filename: filename),
        'description': model.description,
        'name':model.name,
        'price':model.price,
        'size':model.size,
        'location_id':model.location_id,
        'category_id':model.category_id,

      });
      dio.options.headers= {
        'Authorization':
        token,

      };

       return await dio.post(ITEMS,data:formData );

      }
      //return await dio.post(ITEMS,data:formData );



}