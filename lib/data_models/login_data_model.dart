class LoginModel {

  late int? status;
  late String message;
  late UserData data;

  LoginModel.fromJson(Map<String,dynamic> json,this.status){
    message=json['message'];
    if(json.containsKey('data')){
      data=UserData.fromJson(json['data']);
    }
  }
}

class UserData{

  late int id;
  late String name;
  late String email;
  late String phone;
  late String? image;
  late String token;

  UserData(this.id, this.name, this.email, this.phone, this.image, this.token);

  UserData.fromJson(Map<String,dynamic> data){
    this.id=data['id'];
    this.name=data['name'];
    this.email=data['email'];
    this.phone=data['phone_number'];
    this.image=data['picture'];
    this.token=data['token'];

  }
}