import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/models/cart_item.dart';
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/login/models/user_data_model.dart';
import 'package:collection/collection.dart';

class AppProvider extends ChangeNotifier {
  UserDataModel? userData;
  Set<CartItem> cart = <CartItem>{};
  int totalAmount = 0;

  CartItem _addProductToCart(Product product) {
    CartItem item = CartItem(product: product);
    cart.add(item);
    notifyListeners();
    return item;
  }

  void _removeProductFromCart(Product product) {
    cart.removeWhere((element) => element.product == product);
    notifyListeners();
  }

  void removeItemFromCart(CartItem cartItem) {
    cart.remove(cartItem);
    notifyListeners();
  }

  void incrementQuantityByCartItem(CartItem? cartItem, Product product) {
    if (cartItem == null) {
      _addProductToCart(product);
    } else {
      cartItem.incrementQuantityByUnit();
    }

    notifyListeners();
  }

  void decrementQuantityByCartItem(CartItem cartItem) {
    int remainingItems = cartItem.decrementQuantityByUnit();
    if (remainingItems <= 0) cart.remove(cartItem);

    notifyListeners();
  }

  void incrementQuantityByProduct(Product product) {
    cart
        .singleWhere((cartItem) => cartItem.product == product,
        orElse: () => _addProductToCart(product))
        .incrementQuantityByUnit();

    notifyListeners();
  }

  void decrementQuantityByProduct(Product product) {
    var cartItem = cart.singleWhereOrNull((cartItem) =>
    cartItem.product == product &&
        (cartItem.decrementQuantityByUnit() <= 0));

    if (cartItem != null) removeItemFromCart(cartItem);

    notifyListeners();
  }

  // void setQuantity(Product product, int quan) {
  //   cart
  //       .firstWhere((element) => element.product.id == product.id)
  //       .setQuantity(quan);
  //   notifyListeners();
  // }

  // void removeProductFromCart(CartItem cartItem) {
  //   cart.removeWhere((cartItem) => cartItem.product.id == product.id);
  //   notifyListeners();
  // }

  int getTotalAmount() {
    int total = 0;
    total = cart
        .map((item) => item.totalPrice)
        .toList()
        .sum;
    return total;
  }

  int getNumOfCartProducts() => cart.length;

  CartItem getItemFromCartByIndex(int index) => cart.elementAt(index);

  CartItem? getItemFromCartByProductId(int productId) =>
      cart.singleWhereOrNull((element) => element.product.id == productId);

  int getProductQuantityByProductId(Product product) =>
      cart
          .singleWhereOrNull((cartItem) => cartItem.product == product)
          ?.quantity ?? 0;


  int getProductTotalByProductId(Product product) => cart
      .singleWhereOrNull((cartItem) => cartItem.product == product)
      ?.totalPrice ?? 0;

  void logOut() {
    userData = null;
  }
}
