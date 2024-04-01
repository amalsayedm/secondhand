class ChangeFavouriteModel{

  late bool status;
  late String message;

  ChangeFavouriteModel(Map<String,dynamic> json){
      status=json['status'];
      message=json['message'];

  }
}