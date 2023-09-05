

abstract class CartStates{
}


class AppIntialState extends CartStates{


}

class GetAllProductsSuccessState extends CartStates{

  GetAllProductsSuccessState();
}

class GetAllProductsLoadingState extends CartStates{
  GetAllProductsLoadingState();
}


class GetAllProductsErrorState extends CartStates{
  String error;
  GetAllProductsErrorState(this.error);
}


class AddProductProductSuccessState extends CartStates{

  AddProductProductSuccessState();
}

class AddProductProductLoadingState extends CartStates{
  AddProductProductLoadingState();
}


class AddProductProductErrorState extends CartStates{
  String error;
  AddProductProductErrorState(this.error);
}


class DeleteAllSuccessState extends CartStates{
  DeleteAllSuccessState();
}

 class DeleteAllLoadingState extends CartStates{
  DeleteAllLoadingState();
}


class DeleteAllErrorState extends CartStates{
  String error;
  DeleteAllErrorState(this.error);
}

class GetTotalPriceSuccessState extends CartStates{
  GetTotalPriceSuccessState();
}

class IncreaseQuantitySuccessState extends CartStates{

  IncreaseQuantitySuccessState();

}






class AnimateImageSuccessState extends CartStates{

  AnimateImageSuccessState();

}


class NextImageSuccessState extends CartStates{

  NextImageSuccessState();

}

class ChangeSelectedOptionState extends CartStates{

  ChangeSelectedOptionState();

}


class GetImageSuccessState extends CartStates{

  GetImageSuccessState();

}


class CashOnDeliverySuccessState extends CartStates{

  CashOnDeliverySuccessState();

}

class CashOnDeliveryErrorState extends CartStates{

  CashOnDeliveryErrorState();

}









class ChangeLoadSuccessState extends CartStates{

  ChangeLoadSuccessState();

}

class DecreaseQuantitySuccessState extends CartStates{

  DecreaseQuantitySuccessState();

}

class GetDataFireBaseSuccessState extends CartStates{

  GetDataFireBaseSuccessState();

}

class GetDataFireBaseLoadingState extends CartStates{

  GetDataFireBaseLoadingState();

}

class GetDataFireBaseErrorState extends CartStates{

  GetDataFireBaseErrorState();

}

class AddToFireBaseSuccessState extends CartStates{

  AddToFireBaseSuccessState();

}

class AddToFireBaseLoadingState extends CartStates{

  AddToFireBaseLoadingState();

}

class AddToFireBaseErrorState extends CartStates{

  AddToFireBaseErrorState();

}




class DeleteFromFavSuccessState extends CartStates{

  DeleteFromFavSuccessState();

}

class DeleteFromFavLoadingState extends CartStates{

  DeleteFromFavLoadingState();

}

class DeleteFromFireBaseErrorState extends CartStates{

  DeleteFromFireBaseErrorState();

}




