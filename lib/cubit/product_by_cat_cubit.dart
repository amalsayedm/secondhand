import 'package:alx_spec/cubit/product_by_cat_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_models/product_model.dart';
import '../network/dio_helper.dart';
import '../network/endpoints.dart';
import '../shared/shared_components.dart';

class ProductByCatCubit extends Cubit<ProductByCatStates>{
  int catID;
  ProductModel  productModel= ProductModel({},0);
  ProductByCatCubit(this.catID):super(ProductByCatInitialSate()){

    getproducts();
  }
  static ProductByCatCubit get(context) {
    return BlocProvider.of(context);
  }
  void getproducts() {
    emit(ProductByCatLoadingState());
    DioHelper.getData(path: PRODUCTS_BY_CAT+(catID.toString()),).then((value) {
      print("items: $value.data");
      productModel = ProductModel(value.data,value.statusCode);
      //print(productModel.products);
      emit(ProductByCatSuccessState());
    }).catchError((onError) {
      toast("error loading items", Colors.amber);
      print(onError.toString());

      emit(SProductByCatErrorState());
    });
  }

}



