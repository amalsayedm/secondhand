
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/shared_pref_helper.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates>{

  MainCubit() : super(MainInitialState());

  static MainCubit get(context){
    return BlocProvider.of(context);
  }

  bool lightMode=  true;

  getThemeMode(){
    dynamic mode=SharedPrefHelper.getFromSharedPref(key: 'light_mode');
    if(mode!=null){
       lightMode=mode;
    }

  }
  void toggleThemeMode(){
    lightMode=!lightMode;
    SharedPrefHelper.setBool(key: 'light_mode', value: lightMode).then((value){
      emit(MainChangeThemeState());

    });

  }

}