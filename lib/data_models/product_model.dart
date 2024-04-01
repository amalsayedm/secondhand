class ProductModel{

  late int? status;
   late List<dynamic> items;
   late int? next_page =0;
  List<Product>products = [];

  ProductModel(Map<String,dynamic> json,this.status){
    next_page = json['next_page'];
    if(json.containsKey('items')){
    items=json['items'];
    if (json['items'] != null) {
      json['items'].forEach((element) {
        products.add(Product.fromJson(element));
      });
    }}

  }
}


class Banner{
  late int id;
  late String image,category,product;

  Banner.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
    category=json['category'];
    product=json['product'];

  }


}

class Product{

  late int id, category_id,location_id,price,user_id;
  late  dynamic size;
  late  String image,name,description,contact,location_name;
  late bool in_favorites,in_cart;


  Product.fromJson(Map<String,dynamic> json){
    id=json['id'];
    category_id=json['category_id'];
    location_id=json['location_id'];
    price=json['price'];
    size=json['size']!=null?json['size']:"-";
    // in_cart=json['in_cart'];
    // in_favorites=json['in_favorites'];
    image=json['picture'];
    name=json['name'];
    description=json['description'];
    contact=json['contact'];
    location_name=json['location_name'];


  }


}

