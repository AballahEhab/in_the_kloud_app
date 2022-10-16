import 'dart:convert';

import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart';
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/product_details/data_source/remote/products_details_service.dart';

class ProductsDetailsRepository {
  final ProductsDetailsService _productsDetailsService =
      ProductsDetailsService();

  Future<ResultData> getProductById(String tokenValue, int productId) async {
    try {
      var response =
          await _productsDetailsService.getProductsById(tokenValue, productId);
      if (response.statusCode == 200) {
        Product responseBodyObj = Product.fromJson(jsonDecode(response.body));
        return ResultData.success(responseBodyObj);
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }
    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }
  }
}
