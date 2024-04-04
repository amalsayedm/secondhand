import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Search_cubit.dart';
import '../cubit/Search_states.dart';
import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../data_models/search_model.dart';
import '../shared/shared_components.dart';

class SearchScreen extends StatelessWidget {

 TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context){ return SearchCubit();}
    ,child: BlocConsumer<SearchCubit,SearchStates>(
        listener:(context,state){} ,
        builder:(context,state){
          SearchCubit cubit=SearchCubit.get(context);
          return Scaffold(appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                defaultFormField(controller: searchController,
                    inputType: TextInputType.text,
                    labeltext: "Search",
                    prefixicon: Icons.search_sharp,
                    onsubmit: (String value){
                      //SearchCubit.get(context).getSearchResult(value);
                    },
                    validator: (String value) {}),
                SizedBox(height: 10,),
                if(state is SearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 20,),
                if(cubit.searchModel!=null&&cubit.searchModel.data.data.length!=0)
                Expanded(
                  child: ListView.separated(
          itemBuilder: (context,int index){
          return buildItem(cubit.searchModel.data.data[index], cubit,context);
          },
          separatorBuilder: (context,int index){
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: divider(),
          );
          },
          itemCount: cubit.searchModel.data.data.length
          ,),
                ),
           ],
          ),
    ) ,
      );
  }
        ));
  }

Widget buildItem(Search product,SearchCubit cubit,context){
  return Container(height: 120,
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(product.images[0]),width:120,
              height: 120,fit: BoxFit.cover,),

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

                    ],),
                    Spacer(),
                   IconButton(
                      icon:
                      CircleAvatar(key: Key("t"),radius: 15,
                          backgroundColor: product.in_favorites?Colors.deepOrange:Colors.grey,
                          child: Icon(Icons.favorite_outline,size: 14,color: Colors.white,))
                      ,onPressed: (){
                      ShopLayoutCubit.get(context).updateFavourite(id:product.id);
                      product.in_favorites=!product.in_favorites;
                      cubit.emit(SearchFavouriteState());

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
