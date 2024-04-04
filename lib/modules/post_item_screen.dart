

import 'dart:io';
import 'dart:ui';

import 'package:alx_spec/data_models/categories_model.dart';
import 'package:alx_spec/data_models/location.dart';
import 'package:alx_spec/data_models/location_model.dart';
import 'package:alx_spec/data_models/post_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/category.dart';
import '../shared/shared_components.dart';

class PostItemScreen extends StatelessWidget {

  var nameController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var sizeController = new TextEditingController();
  var locController = new TextEditingController();
  var priceController = new TextEditingController();
  var catController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
        builder:(context,state) {
          ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
          return Stack(
            children: [Center(
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Insert your Product Details',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 150,
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: cubit.image == null
                                        ? Text('No image selected.')
                                        : Image.file(cubit.image!),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    cubit.getImage();
                                  },
                                  child: Text('* Select image'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: nameController,
                          maxLength: 15,
                          decoration: InputDecoration(
                              labelText: '* Name',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: '* Description',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: priceController,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: '* Price',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton<Category>(
                            value:cubit.selectedCat,
                            hint: Text('* Select a category'),
                            items: cubit.categoriesModel.list.map((item) {
                              return DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                          
                              cubit.selectedCat = newValue!;
                              cubit.emit(ShopLayoutDropDownBoxValueChanged());


                            },isExpanded: true,borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 5),
                          child: DropdownButton<Location>(
                            value:cubit.selectedLoc,
                            hint: Text('* Select a location'),
                            items: cubit.locationModel.list.map((item) {
                              return DropdownMenuItem<Location>(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (newValue) {

                              cubit.selectedLoc = newValue!;
                              cubit.emit(ShopLayoutDropDownBoxValueChanged());

                            },isExpanded: true,borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: sizeController,
                          maxLength: 10,
                          decoration: InputDecoration(
                              labelText: 'Size.',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (nameController.text.isNotEmpty &&
                                descriptionController.text.isNotEmpty &&
                                priceController.text.isNotEmpty&&
                                cubit.selectedLoc!=null &&
                                cubit.selectedCat!=null
                                && cubit.image!=null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirmation"),
                                    content: Text(
                                        "Are you sure you want to submit these details?"),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Color(0xFFCCCCCC)),
                                        ),
                                        onPressed: () {
                                          nameController.clear();
                                          priceController.clear();
                                          descriptionController.clear();
                                          sizeController.clear();

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(color: Color(0xFFCCCCCC)),
                                        ),
                                        onPressed: () async {
                                          var imageName = DateTime.now().millisecondsSinceEpoch.toString()+nameController.text;
                                          int price = int.tryParse(priceController.text) ?? 0;

                                          PostItemModel model =PostItemModel(cubit.selectedCat!.id, cubit.selectedLoc!.id, price, sizeController.text, nameController.text, descriptionController.text);
                                         cubit.uploadPostItem(image: cubit.image,itemmodel: model,imagename: imageName);
                                          // Upload image file to Firebase Storage
                                          //var storageRef = FirebaseStorage.instance.ref().child('driver_images/$imageName.jpg');
                                         // var uploadTask = storageRef.putFile(_image!);
                                          //var downloadUrl = await (await uploadTask).ref.getDownloadURL();

                                          // firestore.collection("Driver Details").add({
                                          //   "Name": nameController.text,
                                          //   "Age": ageController.text,
                                          //   "Driving Licence": dlController.text,
                                          //   "Address.": adController.text,
                                          //   "Phone No.": phnController.text,
                                          //   // Add image reference to document
                                          //   "Image": downloadUrl.toString()
                                          // });
                                          Navigator.of(context).pop();
                                          nameController.clear();
                                          priceController.clear();
                                          descriptionController.clear();
                                          sizeController.clear();
                                          cubit.selectedLoc =null;
                                          cubit.selectedCat=null;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }else{
                              toast("Please fill the required data",Colors.amber);
                            }
                          },
                          child: Text(
                            "Submit Details",style: TextStyle(color: Color(0xFFCCCCCC)),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6E86B4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
              if (state is ShopLayoutUploadItemeLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),]);}
    );
  }


  }

 
  
