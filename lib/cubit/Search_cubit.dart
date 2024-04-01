import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../data_models/search_model.dart';
import '../network/dio_helper.dart';
import '../network/endpoints.dart';
import '../shared/shared_components.dart';
import 'Search_states.dart';

class SearchCubit extends Cubit<SearchStates>{


  late  SearchModel searchModel;
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) {
    return BlocProvider.of(context);
  }

  void getSearchResult(String text) {

    emit(SearchLoadingState());
    DioHelper.postData(path:SEARCH, token: token,
        data:{
          "text": text,
        } ).then((value) {
      print(value.data);
      if(value.data['status']){
        searchModel = SearchModel(value.data);

        emit(SearchSuccessState());
      }else{
        toast(searchModel.message, Colors.amber);

      }

    }).catchError((onError) {
      print(onError.toString());

      emit(SearchErrorState());
      toast("Something went wrong", Colors.red);
    });
  }


}