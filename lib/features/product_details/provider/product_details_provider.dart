import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart'
    as result_data;
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/product_details/repository/products_details_repository.dart';

class ProductDetailsProvider extends ChangeNotifier {

  final ProductsDetailsRepository _repo = ProductsDetailsRepository();

  Product? productDetails;

  String token = '';

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void getProductDetails(int productId) async {
      clearErrorMessage();
      enableLoading();
      var responseResult =
          await _repo.getProductById(token, productId);
      switch (responseResult.runtimeType) {
        case result_data.Success:
          productDetails =
              (responseResult as result_data.Success<dynamic>).data;
          break;
        case result_data.Error:
          _errorMessage =
              (responseResult as result_data.Error<dynamic>).msg as String;
          break;
      }
      disableLoading();
  }

  void disableLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void enableLoading() {
    _isLoading = true;
    notifyListeners();
  }

  set errorMessage(String? errorMsg) {
    _errorMessage = errorMsg;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

}
