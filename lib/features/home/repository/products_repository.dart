import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart';
import 'package:in_the_kloud_app/features/home/data_source/remote/products_Service.dart';
import 'package:in_the_kloud_app/features/home/models/products_data_model.dart';

class ProductsRepository {
  final ProductsService _productsService = ProductsService();

  Future<ResultData> getAllCategories(String tokenValue) async {
    try {
      var response = await _productsService.getAllCategories(tokenValue);
      if (response.statusCode == 200) {
        List<dynamic> responseBody = List<String>.from(jsonDecode(response.body));
        return ResultData.success(responseBody);
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }
    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }
  }

  Future<ResultData> getProductsByCategoryName(
      String tokenValue, String categoryName) async {
    try {
      var response = await _productsService.getProductsByCategoryName(
          tokenValue, categoryName);
      if (response.statusCode == 200) {
        ProductsDataModel responseBodyObj =
            await compute<Map<String, dynamic>, ProductsDataModel>(
                ProductsDataModel.fromJson, jsonDecode(response.body));
        return ResultData.success(responseBodyObj.products);
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }
    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }
  }

  Future<ResultData> getAllProducts(String tokenValue) async {
    try {
      var response = await _productsService.getAllProducts(tokenValue);
      if (response.statusCode == 200) {
        ProductsDataModel responseBodyObj =
            await compute<Map<String, dynamic>, ProductsDataModel>(
                ProductsDataModel.fromJson, jsonDecode(response.body));
        return ResultData.success(responseBodyObj.products);
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }
    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }
  }
}
