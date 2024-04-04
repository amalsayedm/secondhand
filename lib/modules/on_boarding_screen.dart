import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../shared/shared_components.dart';
import '../shared/shared_pref_helper.dart';
import 'login_screen.dart';
class OnBoardingData{
  String Title,body;

  OnBoardingData(this.Title, this.body);
}
class OnBoardingScreen extends StatelessWidget {


    var boardingController=PageController();
    List<OnBoardingData> boardingData=[
      OnBoardingData("Diversity","a lot of various products"),
      OnBoardingData("Detailing","obvious details for each product"),
      OnBoardingData("Simplicity","easy to choose your favourites"),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [
      TextButton(onPressed: (){
        onSubmit(context);
      }, child: Text('skip',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
    ],),
    body:Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(itemBuilder: (context,index){
              return onBoardingItem(index);
            },itemCount: 3,physics: BouncingScrollPhysics(),controller: boardingController,),
          ),
          SizedBox(height: 40,),
          Row(children: [
            SmoothPageIndicator(controller: boardingController, count: 3,
              effect: ScrollingDotsEffect(activeDotColor:  Colors.deepOrange),),
            Spacer(),
            FloatingActionButton(onPressed: (){
              int page= boardingController.page!.toInt();
              print("current page $page");
              if(page==2){
                onSubmit(context);
              }else{
                boardingController.nextPage(duration: Duration(milliseconds: 750),
                    curve:Curves.fastLinearToSlowEaseIn);
              }

              },child: Icon(Icons.arrow_forward_ios),)
          ],),
        ],
      ),
    ) ,);
  }

  Widget onBoardingItem(int index){
    return Column(crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage('assets/images/shop_image.jpg'))),
        SizedBox(height: 20,),
        Text(boardingData[index].Title,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text(boardingData[index].body,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),


      ],);
  }

  void onSubmit(context){
    SharedPrefHelper.setBool(key: "onBoarding", value: false).then((value) {
      if(value){
        navigateAndFinish(context,LoginScreen());

      }
    });

  }
}
