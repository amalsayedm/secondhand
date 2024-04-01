import 'dart:io';

import 'package:alx_spec/shared/shared_components.dart';
import 'package:alx_spec/shared/shared_pref_helper.dart';
import 'package:alx_spec/shop_layout/shop_layout.dart';
import 'package:alx_spec/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/main_cubit.dart';
import 'cubit/main_states.dart';
import 'cubit/shop_layout_cubit.dart';
import 'modules/login_screen.dart';
import 'modules/on_boarding_screen.dart';
import 'network/dio_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:[
      BlocProvider(create:(context){return MainCubit();}),
      BlocProvider(create: (context){return ShopLayoutCubit();}),
    ] ,
      child: BlocConsumer<MainCubit,MainStates>(listener: (context,state){},
        builder:(context,state){
          bool isBoarding=true;
          bool isToken= false;
          MainCubit.get(context)..getThemeMode();
          print("is boarding ${SharedPrefHelper.getFromSharedPref(key:'onBoarding')}");
          if(SharedPrefHelper.getFromSharedPref(key:'onBoarding')!=null){
            if(SharedPrefHelper.getFromSharedPref(key: "token")!=null){
              isToken=true;
              token=SharedPrefHelper.getFromSharedPref(key: "token");
            }
            isBoarding=false;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: MainCubit.get(context).lightMode?ThemeMode.light:ThemeMode.dark,
            home:isBoarding?OnBoardingScreen():isToken?ShopLayout():LoginScreen(),
          );
        } ,),);

  }
}


