import 'dart:developer';
import 'dart:io';


import 'package:alx_spec/cubit/shop_layout_states.dart';
import 'package:alx_spec/data_models/categories_model.dart';
import 'package:alx_spec/data_models/location.dart';
import 'package:alx_spec/data_models/location_model.dart';
import 'package:alx_spec/modules/post_item_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../data_models/categories_model.dart';
import '../data_models/category.dart';
import '../data_models/change_favourite_model.dart';
import '../data_models/favourite_model.dart';
import '../data_models/login_data_model.dart';
import '../data_models/product_model.dart';
import '../modules/categories_screen.dart';
import '../modules/favourites_screen.dart';
import '../modules/products_screen.dart';
import '../modules/settings_screen.dart';
import '../network/dio_helper.dart';
import '../network/endpoints.dart';
import '../shared/shared_components.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    PostItemScreen(),
    FavouritesScreen(),
    SettingsScreen(),

  ];
  File? image = null;
  int navBarIndex = 0;
  Category? selectedCat = null;
  Location? selectedLoc=null;

  ProductModel productModel = ProductModel({}, 0);
  CategoriesModel categoriesModel=CategoriesModel([], 0);
  late FavouriteModel favouriteModel;
  late LoginModel? profileModel = null;
  LocationModel locationModel = LocationModel([], 0);



  ShopLayoutCubit() : super(ShopLayoutInitialSate()) {
    getHomeData();
   getCategoriesData();
   getLocation();
   // getFavourite();
    getProfile();
  }


  static ShopLayoutCubit get(context) {
    return BlocProvider.of(context);
  }

  changeNavBarIndex(int index) {
    navBarIndex = index;
    switch (navBarIndex){
      case 0:
        { print("amaal$navBarIndex");
          getHomeData();
        getCategoriesData();
        getLocation();}

    }
    emit(ShopLayoutChangeNavBarState());
  }

  void getHomeData() {
    emit(ShopLayoutHomeLoadingState());
    DioHelper.getData(path: HOME, lang: "en", token: token).then((value) {
      print("items: $value.data");
      productModel = ProductModel(value.data,value.statusCode);
      //print(productModel.products);
      emit(ShopLayoutHomeSuccessState());
    }).catchError((onError) {
      toast("error loading items", Colors.amber);
      print(onError.toString());

      emit(ShopLayoutHomeErrorState());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(path: CATEGORIES, lang: "en").then((value) {
      print(value.data);
      categoriesModel = CategoriesModel(value.data,value.statusCode);
      emit(ShopLayoutCategoriesSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      toast("Can't load categories", Colors.amber);
      emit(ShopLayoutCategoriesErrorState());
    });
  }

  void updateFavourite({required int id,bool isFavourite=false}) {
    emit(ShopLayoutUpdateFavouriteLoadingState(id));
    bool ?helper;
    DioHelper.postData(path: FAVOURITE, data: {
      "product_id": id
    }, token: token).then((value) {
      print(value);
      ChangeFavouriteModel favmodel = ChangeFavouriteModel(value.data);
      if (favmodel.status) {
        // productModel.data?.products.forEach((element) {
        //   if (element.id == id) {
        //     element.in_favorites = !element.in_favorites;
        //   }
        // });
        if(isFavourite){
          favouriteModel.data.data.removeWhere((element){
            if(element.product.id==id){
             return helper!;
            }
            return false;
          });
        }
        emit(ShopLayoutUpdateFavouriteSuccessState());
        getFavourite();

      }
      else {
        toast(favmodel.message, Colors.red);
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopLayoutUpdateFavouriteErrorState());
    });
  }

  void getFavourite() {

    DioHelper.getData(path: FAVOURITE, token: token).then((value) {
      print(value.data);
      favouriteModel = FavouriteModel(value.data);
      emit(ShopLayoutFavouriteSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLayoutFavouriteErrorState());
    });
  }

  void getProfile() {
    DioHelper.getData(path: PROFILE, token: token).then((value) {
      print(value.data);
      profileModel = LoginModel.fromJson(value.data,value.statusCode);
      emit(ShopLayoutProfileSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLayoutProfileErrorState());
    });
  }

  void updateProfile(String name,String phone,String email) {
    emit(ShopLayoutUpdateProfileLoadingState());


    DioHelper.putData(path: UPDATE_PROFILE, token: token,
        data:{
          "name": name,
          "phone_number": phone,
          "email":email,

        } ).then((value) {
      print(value.statusCode);
      if(value.statusCode==200){
        profileModel = LoginModel.fromJson(value.data,value.statusCode);
        toast(profileModel!.message, Colors.green);

        emit(ShopLayoutUpdateProfileSuccessState());
      }else{
        toast(profileModel!.message, Colors.amber);

      }

    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLayoutUpdateProfileErrorState());
      toast("Something went wrong", Colors.red);
    });
  }
   getImage() async {
    final ImagePicker _picker = ImagePicker();
// Pick an image
     try{
    final XFile? Pimage = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
    image=File(Pimage!.path);
    emit(ShopLayoutUpdatePickImageSuccess());
  }catch(onerror){
       emit(ShopLayoutUpdatePickImageError());

     }
  }
   uploadPostItem(
      {required image, required itemmodel, required imagename}) async {

    emit(ShopLayoutUploadItemeLoading());
      DioHelper.PostItem_with_Image(
          image: image, filename: imagename, model: itemmodel).
      then((value) {
        if (value.statusCode == 201) {
          print('success');
          toast("Item Posted Successfully", Colors.amber);
          image = null;
          emit(ShopLayoutUploadItemeSuccess());

        }
      }).catchError((onError) {
        log(onError.toString());
        toast("Something went wrong", Colors.red);
    emit(ShopLayoutUploadItemeError());
    });

  }

  void getLocation() {
    DioHelper.getData(path: LOCATION,).then((value) {
      print(value.data);
      locationModel = LocationModel(value.data,value.statusCode);
      emit(ShopLayoutLocationSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopLayoutLocationErrorState());
    });
  }
}