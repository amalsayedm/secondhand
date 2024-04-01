import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shop_layout_cubit.dart';
import '../cubit/shop_layout_states.dart';
import '../data_models/categories_model.dart';
import '../modules/search_screen.dart';
import '../shared/shared_components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},builder: (context,state){
        ShopLayoutCubit cubit=ShopLayoutCubit.get(context);
        return Scaffold(appBar: AppBar(title: Text("Shop"),
          actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            navigateTo(context,SearchScreen());
          }),
        ],),
          body: cubit.screens[cubit.navBarIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.navBarIndex,
            onTap: (int index){
              cubit.changeNavBarIndex(index);
            },
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Products"),
              BottomNavigationBarItem(icon:  Icon(Icons.apps),label:"Categories"),
              BottomNavigationBarItem(icon:  Icon(Icons.favorite),label:"Favourites"),
              BottomNavigationBarItem(icon:  Icon(Icons.settings),label:"settings"),


          ],),);
    }, );
  }
}
