class Location{
  late int  id;
  late String name;

  Location.fromJson(Map<String,dynamic> json){

    id=json['id'];
    name=json['name'];

  }

  Location(this.id, this.name);
}

