import 'package:alx_spec/cubit/shop_layout_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data_models/categories_model.dart';
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
    FavouritesScreen(),
    SettingsScreen(),

  ];
  int navBarIndex = 0;
   ProductModel productModel = ProductModel({}, 0);
  late CategoriesModel categoriesModel=CategoriesModel([], 0);
  late FavouriteModel favouriteModel;
  late LoginModel profileModel;


  ShopLayoutCubit() : super(ShopLayoutInitialSate()) {
    getHomeData();
   getCategoriesData();
   // getFavourite();
    getProfile();
  }


  static ShopLayoutCubit get(context) {
    return BlocProvider.of(context);
  }

  changeNavBarIndex(int index) {
    navBarIndex = index;
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
        toast(profileModel.message, Colors.green);

        emit(ShopLayoutUpdateProfileSuccessState());
      }else{
        toast(profileModel.message, Colors.amber);

      }

    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLayoutUpdateProfileErrorState());
      toast("Something went wrong", Colors.red);
    });
  }
}