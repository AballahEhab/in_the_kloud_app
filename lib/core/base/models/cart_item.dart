import 'package:in_the_kloud_app/features/home/models/product_model.dart';

class CartItem{
  Product product;
  int quantity = 0;
  int totalPrice = 0;

  CartItem({required this.product, int pQuantity = 0}){
    setQuantity(pQuantity);
  }

  void incrementQuantityByUnit(){
    quantity++;
    totalPrice += product.price!;
  }

  int decrementQuantityByUnit(){
    totalPrice -= product.price!;
    return --quantity;
  }

  void setQuantity(int quan){
    quantity = quan;
    totalPrice = (product.price! * quantity);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          product.id == other.product.id;

  @override
  int get hashCode => product.id!;
}


