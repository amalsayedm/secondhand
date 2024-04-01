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
class Category{
 late int  id;
  late String name,image;

  Category.fromJson(Map<String,dynamic> json){

    id=json['id'];
    name=json['name'];
    image=json['picture'];

  }


}


