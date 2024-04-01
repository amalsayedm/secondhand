import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../data_models/favourite_model.dart';
import '../shared/shared_components.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
        return cubit.favouriteModel != null
            ? cubit.favouriteModel.data.data.isEmpty
            ? Center(
          child: Text(
            "No Favorites Yet",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.separated(
          itemBuilder: (context, int index) {
            return buildItem(
                cubit.favouriteModel.data.data[index].product, cubit);
          },
          separatorBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: divider(),
            );
          },
          itemCount: cubit.favouriteModel.data.data.length,
        )
            : Center(child: CircularProgressIndicator());
      },);
  }

  Widget buildItem(Product product,ShopLayoutCubit cubit){
    return Container(height: 120,
      padding: const EdgeInsets.all(10),
      child: Row(
      children: [
      Stack(alignment: AlignmentDirectional.bottomStart,
      children: [
      Image(image: NetworkImage(product.image),width:120,
      height: 120,fit: BoxFit.cover,),

      if(product.discount!=0)
      Container(color: Colors.red,
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text("Discount",style: TextStyle(color: Colors.white),),
      ))
      ],
      ),

      Expanded(
        child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 5,start: 5,end: 5),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(product.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
          Spacer(),
          Row(
        children: [
        Row(children: [
        Text(product.price.toString(),style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),
        SizedBox(width: 5,),
        if(product.discount!=0)
        Text(product.old_price.toString(),style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),

        ],),
        Spacer(),
        (cubit.state is ShopLayoutUpdateFavouriteLoadingState && (cubit.state as ShopLayoutUpdateFavouriteLoadingState).id==product.id)?
        IconButton(iconSize: 10,
        icon:CircularProgressIndicator(strokeWidth: 2,)
        ,onPressed: (){
        },):IconButton(
        icon:
        CircleAvatar(radius: 15,
        backgroundColor:Colors.deepOrange,
        child: Icon(Icons.favorite_outline,size: 14,color: Colors.white,))
        ,onPressed: (){
        cubit.updateFavourite(id:product.id,isFavourite: true);

        },),

        ],
        ),
        ],
        ),
        ),
      ),
      // SizedBox(height: 5,),

      ],),
    );
  }
}
