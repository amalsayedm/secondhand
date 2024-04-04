import 'package:alx_spec/modules/products_by_cat_screen.dart';
import 'package:alx_spec/network/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../data_models/category.dart';
import '../shared/shared_components.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
         listener: (context,state){},builder: (context,state){
           dynamic contextc=context;
           ShopLayoutCubit c=ShopLayoutCubit.get(context);
           return c.categoriesModel.list.isNotEmpty
               ? ListView.separated(
             itemBuilder: (context, int index) {
               return buildListItem(contextc,c.categoriesModel.list[index]);
             },
             separatorBuilder: (context, int index) {
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: divider(),
               );
             },
             itemCount: c.categoriesModel.list.length,
           )
               : Center(child: CircularProgressIndicator());
    },);
  }

 Widget buildListItem(context,Category category){
   return GestureDetector(
       onTap: (){
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => ProductsByCat(category.id,category.name),
           ),
         );
       },
     child: Padding(
       padding: const EdgeInsets.all(20),
       child: Row(children: [
         Image(image: NetworkImage(CATEGORIES_IMAGES+category.image),width: 100,height: 100,),
         SizedBox(width: 10,),
         Expanded(child:Text(category.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
         Spacer(),
         Icon(Icons.arrow_forward_ios),
       ],),
     ),
   );
  }
}
