


 class CartProductModel {
  String  ? name, image, price, productId,color,size;
  num   ? quantity,productQuant;


  CartProductModel(
      {this.name, this.image, required this.quantity,required this.productQuant, this.price,
        this.productId,this.color,this.size});

  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
    quantity = map['quant'];
    productQuant = map['productQuant'];
    color=map['color'];
    size=map['size'];
    print("s=$size");
    print("c=$color");
    price=map['price'];
    productId = map['productid'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'quant': quantity,
      'productQuant':productQuant,
      'price': price,
      'productid': productId,
      'color':color,
      'size':size
      //'brand':brand,
      //  'brandemail':brand_email
    };
  }
}
