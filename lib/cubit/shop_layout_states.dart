abstract class ShopLayoutStates{}

class ShopLayoutInitialSate extends ShopLayoutStates{}

class ShopLayoutChangeNavBarState extends ShopLayoutStates{}

class ShopLayoutHomeLoadingState extends ShopLayoutStates{}
class ShopLayoutHomeSuccessState extends ShopLayoutStates{}
class ShopLayoutHomeErrorState extends ShopLayoutStates{}

class ShopLayoutCategoriesSuccessState extends ShopLayoutStates{}
class ShopLayoutCategoriesErrorState extends ShopLayoutStates{}

class ShopLayoutUpdateFavouriteSuccessState extends ShopLayoutStates{}
class ShopLayoutUpdateFavouriteErrorState extends ShopLayoutStates{}
class ShopLayoutUpdateFavouriteLoadingState extends ShopLayoutStates{
  int id;

  ShopLayoutUpdateFavouriteLoadingState(this.id);
}

class ShopLayoutFavouriteSuccessState extends ShopLayoutStates{}
class ShopLayoutFavouriteErrorState extends ShopLayoutStates{}

class ShopLayoutProfileSuccessState extends ShopLayoutStates{}
class ShopLayoutProfileErrorState extends ShopLayoutStates{}

class ShopLayoutUpdateProfileLoadingState extends ShopLayoutStates{}
class ShopLayoutUpdateProfileSuccessState extends ShopLayoutStates{}
class ShopLayoutUpdateProfileErrorState extends ShopLayoutStates{}

