
class SearchModel{

  late bool status;
  late String message;
  late Data data;

  SearchModel(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=Data(json['data']);

  }


}

class Data{
  late int current_page;
 List<Search> data=[];

  Data(Map<String,dynamic> json){
    current_page=json['current_page'];
    if(json['data']!=null){
      json['data'].forEach((e){
        data.add(Search.fromJson(e));
      });
    }
  }

}


class Search{
  late  int id;
  late dynamic price;
  late String name,description;
  late bool in_favorites,in_cart;
  late List<dynamic> images;

  Search.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
    name=json['name'];
    description=json['description'];
    images=json["images"];

  }


}
