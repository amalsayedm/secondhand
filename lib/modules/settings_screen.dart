import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../shared/shared_components.dart';
import '../shared/shared_pref_helper.dart';
import 'login_screen.dart';


class SettingsScreen extends StatelessWidget {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder:(context,state) {
        ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
        if (cubit.profileModel != null) {
          if (state is! ShopLayoutUpdateProfileLoadingState) {
            nameController.text = cubit.profileModel.data.name.toString();
            emailController.text = cubit.profileModel.data.email.toString();
            phoneController.text = cubit.profileModel.data.phone.toString();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLayoutUpdateProfileLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20),
                    defaultFormField(
                      controller: nameController,
                      inputType: TextInputType.text,
                      labeltext: "Name",
                      prefixicon: Icons.person,
                      validator: (String text) {
                        if (text.isEmpty) {
                          return "Name must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    defaultFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      labeltext: "Email",
                      prefixicon: Icons.email_outlined,
                      validator: (String text) {
                        if (text.isEmpty) {
                          return "Email must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    defaultFormField(
                      controller: phoneController,
                      inputType: TextInputType.phone,
                      labeltext: "Phone",
                      prefixicon: Icons.phone_android_outlined,
                      validator: (String text) {
                        if (text.isEmpty) {
                          return "Name must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    defaultButton(
                      buttonText: "Update",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateProfile(
                            nameController.text,
                            phoneController.text,
                            emailController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    defaultButton(
                      buttonText: "LogOut",
                      onPressed: () {
                        SharedPrefHelper.removeData("token").then((value) =>
                            navigateAndFinish(context, LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        };
      }
    );
  }
}
