
import '../data_models/login_data_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{

  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{

  String error;
  LoginErrorState(this.error);
}

class LoginPasswordVisibilityChangedState extends LoginStates{


}

class RegisterLoadingState extends LoginStates{}

class RegisterSuccessState extends LoginStates{
  bool state;

  RegisterSuccessState(this.state);
}

class RegisterErrorState extends LoginStates{


}



