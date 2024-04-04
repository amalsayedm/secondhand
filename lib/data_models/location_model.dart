import 'package:alx_spec/data_models/location.dart';

class LocationModel{
  late int? status;
  late List<Location> list=[];


  LocationModel(List<dynamic> json,this.status) {
    if(json!=null) {
      json.forEach((e){
        list.add(Location.fromJson(e));
      });
    }
  }





}


class LocationList{
  //late int current_page;
  late List<Location> list=[];

  LocationList.fromJson(List<dynamic>json){
    //current_page=json['current_page'];
    if(json!=null) {
      json.forEach((e){
        list.add(Location.fromJson(e));
      });
    }

  }




}

