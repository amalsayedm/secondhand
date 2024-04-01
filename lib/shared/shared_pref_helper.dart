import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{

  static late SharedPreferences sharedPreferences;

  static init ()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  
 static Future<bool> setBool({required String key,required bool value})async{
    return  await sharedPreferences.setBool(key, value);
  }

  static dynamic getFromSharedPref({required String key}){
    return sharedPreferences.get(key);
  }

  static Future<bool> saveString({required String key,required String value})async{
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool>removeData( String key)async{
    return await sharedPreferences.remove(key);
  }
}