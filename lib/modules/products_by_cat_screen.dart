
import 'package:alx_spec/cubit/product_by_cat_cubit.dart';
import 'package:alx_spec/cubit/product_by_cat_states.dart';
import 'package:alx_spec/modules/product_details_screen.dart';
import 'package:alx_spec/network/endpoints.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_states.dart';
import '../data_models/product_model.dart';

class ProductsByCat extends StatelessWidget {
  final int catID;
  final String catName;
  const ProductsByCat(this.catID, this.catName,{super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create:(context){return ProductByCatCubit(catID);},
    child:BlocConsumer<ProductByCatCubit,ProductByCatStates>(
      listener: (context,state){},
      builder: (context,state){
        ProductByCatCubit cubit=ProductByCatCubit.get(context)..catID;
        return Scaffold(appBar: AppBar(title: Text(catName,style: TextStyle(fontWeight:FontWeight.bold
        ,fontSize: 18),),centerTitle: true,),body:
        getBodyWidget(context,cubit),);

        },));
  }


  Widget productBuilder(context,ProductByCatCubit cubit){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: GridView.count(shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,crossAxisSpacing: 3,mainAxisSpacing:3,childAspectRatio:1/1.55 ,
                children:
                List.generate(cubit.productModel.products.length, (index) {
                  return buildGridItem(context,cubit.productModel.products[index] as Product,cubit);
                })
                ,),
            ),
          ),
        ],),
    );
  }

  Widget buildGridItem(context,Product product,ProductByCatCubit cubit){

    return GestureDetector(
        onTap: () {
          // Navigate to a new screen with the product data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => product_details_screen(product),
            ),
          );
        },child:Container(color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(PRODUCTS_IMAGES+product.image),width: double.infinity,
                height: 200,),

            ],
          ),

          Padding(
            padding: const EdgeInsetsDirectional.only(top: 5,start: 5,end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Row(
                  children: [
                    Row(children: [
                      Text(product.price.toString()+"L.E.",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                    ],),
                    Spacer(),
                    (cubit.state is ShopLayoutUpdateFavouriteLoadingState && (cubit.state as ShopLayoutUpdateFavouriteLoadingState).id==product.id)?
                    IconButton(iconSize: 10,
                      icon:CircularProgressIndicator(strokeWidth: 2,)
                      ,onPressed: (){
                      },):IconButton(
                      icon:
                      CircleAvatar(radius: 15,
                          // backgroundColor: product.in_favorites?Colors.deepOrange:Colors.grey,
                          child: Icon(Icons.favorite_outline,size: 14,color: Colors.white,))
                      ,onPressed: (){
                      //cubit.updateFavourite(id:product.id);
                    },),

                  ],
                ),
              ],
            ),
          ),
          // SizedBox(height: 5,),

        ],),
    ));

  }
  getBodyWidget( context,ProductByCatCubit cubit){
    if(cubit.productModel.products.isEmpty && cubit.productModel.status==0)
    {return Center(child: CircularProgressIndicator());}
    else if(cubit.productModel.products.isEmpty && cubit.productModel.status==200){
      print("amal($cubit.productModel.status)");
     return Center(child: Text("No Items Yet to buy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),));
    }else if(cubit.productModel.products.isNotEmpty)
    { return productBuilder(context,cubit);}
  }
}


