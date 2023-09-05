
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class ProductModel {
  String ?productId, name, image, des, size,brand,brand_email,x;
  num  ?price;
  num  ?quant;
  String ?  color;

  ProductModel(
      {this.productId,
        this.name,
        this.image,
        this.des,
        this.color,
        this.size,
        this.brand,
        this.x,
        this.brand_email,
        this.price,
        this.quant});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    image = map['image'];
    des = map['des'];
    color = map['color'];
    size= map['size'];
    x=map["x"];




    quant = map['quant'];
    brand = map['brand'];
    price=map['price'];
    brand_email=map['brandemail'];
    productId = map['productid'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'des': des,
      'color': color,
      'size': size,
      'price': price,
      'productid': productId,
      'brand':brand,
      'x':x,
      'brandemail':brand_email
    };
  }
}
