class Category{
  late int  id;
  late String name,image;

  Category.fromJson(Map<String,dynamic> json){

    id=json['id'];
    name=json['name'];
    image=json['picture'];

  }

  Category(this.id, this.name,this.image);
}

