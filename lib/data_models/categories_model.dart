import 'category.dart';

class CategoriesModel {

  late int? status;
  late List<Category> list=[];


  CategoriesModel(List<dynamic> json,this.status) {
    if(json!=null) {
      json.forEach((e){
        list.add(Category.fromJson(e));
      });
    }
    }





  }


class CategoryList{
 //late int current_page;
 late List<Category> list=[];

  CategoryList.fromJson(List<dynamic>json){
    //current_page=json['current_page'];
    if(json!=null) {
      json.forEach((e){
        list.add(Category.fromJson(e));
      });
    }

  }




}



