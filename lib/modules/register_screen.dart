import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import '../shared/shared_components.dart';
import '../shop_layout/shop_layout.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context){return LoginCubit();},
    child: BlocConsumer<LoginCubit,LoginStates>(listener: (context,state){
      if(state is RegisterSuccessState&& state.state==true){
        navigateAndFinish(context,ShopLayout());
      }
    },
    builder:(context,state){
      LoginCubit cubit=LoginCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Register now to browse our hot offers",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  defaultFormField(
                      controller: nameController,
                      inputType: TextInputType.text,
                      labeltext: "Name",
                      prefixicon: Icons.person,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return " please enter your name";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      labeltext: "Email",
                      prefixicon: Icons.email_outlined,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return " please enter email address";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      inputType: TextInputType.phone,
                      labeltext: "Phone",
                      prefixicon: Icons.phone_android,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return " please enter your phone";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: passwordController,
                      inputType: TextInputType.visiblePassword,
                      suffexicon: cubit.passwordSuffixIcon,
                      suffexPressed: (){
                         cubit.changePasswordVisibility();},
                       obscureText: cubit.obscure,
                      labeltext: "Password",
                      prefixicon: Icons.lock_outline,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return " password is too short";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  state is! RegisterLoadingState
                      ? defaultButton(
                    buttonText: "Register",
                    onPressed: () {

                      if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty
                      &&emailController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
                        if(!isValidPhoneNumber(phoneController.text)){
                          toast("Wrong whatsapp number format", Colors.amber);
                        }else {
                          LoginCubit.get(context).register(
                            nameController.text,
                            phoneController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      }else{
                        toast("Please fill up your data", Colors.amber);

                      }

                    },
                  )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      );
    },));

  }

  bool isValidPhoneNumber(String phoneNumber) {
    // Define the regex pattern for the desired format
    RegExp regex = RegExp(r'^0\d{10}$');

    // Check if the phone number matches the pattern
    return regex.hasMatch(phoneNumber);
  }
}
