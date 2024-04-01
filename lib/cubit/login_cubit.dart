import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_models/login_data_model.dart';
import '../network/dio_helper.dart';
import '../network/endpoints.dart';
import '../shared/shared_components.dart';
import '../shared/shared_pref_helper.dart';
import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates>{

  IconData passwordSuffixIcon=Icons.visibility_off;
  bool obscure=true;
  late LoginModel loginModel;

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context){
   return BlocProvider.of(context);
  }

  void changePasswordVisibility(){
    obscure=!obscure;
    passwordSuffixIcon=obscure?Icons.visibility_off:Icons.visibility;

    emit(LoginPasswordVisibilityChangedState());
  }
  void login({@required email,@required password}){
    emit(LoginLoadingState());
    print("'email $email +password $password ");
    DioHelper.postData(path: LOGIN, data: {
      'email':'$email',
      'password':'$password',
    }).then((value){
      print(value.data);
      loginModel=LoginModel.fromJson(value.data,value.statusCode);
      //print(loginModel.message);
     // print(loginModel.data.name);
      toast(loginModel.message, Colors.green);
      if (value.statusCode == 200 || value.statusCode ==201)
        {
          emit(LoginSuccessState(loginModel));
        }
    }).catchError((onError){
      print(onError.toString());
      toast("something went wrong", Colors.amber);
      emit(LoginErrorState(onError.toString()));

    });

  }

  void register(String name,String phone,String email,String password){

    emit(RegisterLoadingState());

    DioHelper.postData(path: REGISTER, data: {
      'email':email,
      'password':password,
      'name':name,
      'phone_number':phone
    }).then((value){
      print(value.data);
      if(value.statusCode == 201){
        SharedPrefHelper.saveString(key: "token", value:value.data['data']['token']).
        then((bool){
          token=value.data['data']['token'];
        });

      toast("User Registered Successfully", Colors.green);
        //emit(RegisterSuccessState(value.data['status']));
        emit(RegisterSuccessState(true));

      }else{
        toast(value.data['message'], Colors.amber );

      }

    }).catchError((onError){
      print(onError.toString());
      toast(onError.toString(), Colors.red);

      emit(RegisterErrorState());

    });
  }

}