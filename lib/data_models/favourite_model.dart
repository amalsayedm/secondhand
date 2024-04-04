
class FavouriteModel{

  late bool status;
  late String message;
  late Data data;

  FavouriteModel(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=Data(json['data']);

  }


}

class Data{
  late int current_page;
  late List<Favourite> data=[];

  Data(Map<String,dynamic> json){
    current_page=json['current_page'];
    if(json['data']!=null){
      json['data'].forEach((e){
        data.add(Favourite(e));
      });
    }
  }

}

class Favourite {
  late int id;
  late Product product;

  Favourite(Map<String,dynamic> json){
    id=json['id'];
    product=Product.fromJson(json['product']);

  }


}

class Product{
  late  int id;
  late dynamic price,old_price,discount;
  late String name,image,description;

  Product.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    name=json['name'];
    image=json['image'];
    description=json['description'];

  }


}
