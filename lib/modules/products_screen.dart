
import 'package:alx_spec/modules/product_details_screen.dart';
import 'package:alx_spec/modules/products_by_cat_screen.dart';
import 'package:alx_spec/network/endpoints.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../data_models/category.dart';
import '../data_models/product_model.dart';
import '../shared/shared_components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext contextb) {

    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
         listener: (context,state){},
      builder: (context,state){
           ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
           if(state is ShopLayoutHomeLoadingState){
             return Center(child: CircularProgressIndicator());
           }
          else if (!(cubit.productModel.products.isEmpty && cubit.categoriesModel.list.isEmpty)) {
             return productBuilder(context,cubit);
           }else{
             return Center(child: CircularProgressIndicator());
           }
      },);
  }


  Widget productBuilder(context,ShopLayoutCubit cubit){
    return SingleChildScrollView(
      child: Column(
        children: [
        // CarouselSlider(items:
        //   cubit.productModel.data!.banners.map((e) =>Image(image: NetworkImage(e.image),
        //    width: double.infinity,fit: BoxFit.cover,) ).toList() ,
        //     options: CarouselOptions(viewportFraction: 1.0,
        //         height: 250,initialPage: 0,enableInfiniteScroll: true,
        //     reverse: false,autoPlay:true,autoPlayInterval:const Duration(seconds: 3),
        //     autoPlayAnimationDuration: const Duration(seconds:1),autoPlayCurve: Curves.fastOutSlowIn,
        //     scrollDirection: Axis.horizontal)),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24),),
              SizedBox(height: 10,),

              Container(height: 100,
                child: ListView.separated(physics:BouncingScrollPhysics(),scrollDirection: Axis.horizontal,
                itemBuilder: (context,int index){
                  return buildCategoryItem(context,cubit.categoriesModel.list[index]);
                }, separatorBuilder: (context,int index){
                  return SizedBox(width: 10,);
    }, itemCount: cubit.categoriesModel.list.length),
              ),
          SizedBox(height: 10,),
              Text("New Products ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24),),
            ],
          ),
        ),
        SizedBox(height: 10,),
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

  Widget buildGridItem(context,Product product,ShopLayoutCubit cubit){

    return GestureDetector(
        onTap: () {
      // Navigate to a new screen with the product data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(product),
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
                Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 5,),
                Text(product.description,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),

                Row(
                  children: [
                    Row(children: [
                      Text(product.price.toString()+" L.E.",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
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

  Widget buildCategoryItem(context,Category category){
    return GestureDetector(
      onTap: () {
        // Navigate to another screen with the item's index
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsByCat(category.id,category.name),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(CATEGORIES_IMAGES + category.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
