import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart'
    as result_data;
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/home/repository/products_repository.dart';

class ProductsProvider extends ChangeNotifier {

  ProductsProvider(this.token) {
    enableCategoriesLoading();
    enableProductsLoading();
  }

  final ProductsRepository _repo = ProductsRepository();

  String token = '';

  List<String>? categoriesList;

  int selectedCategoryIndex = -1;

  List<Product>? productsList;

  List<Product>? shownProductsList;

  bool _isCategoriesLoading = false;

  bool get isCategoriesLoading => _isCategoriesLoading;

  bool _isProductsLoading = false;

  bool get isProductsLoading => _isProductsLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void getAllCategories() async {
      clearErrorMessage();
      enableCategoriesLoading();
      var responseResult = await _repo.getAllCategories(token);
      switch (responseResult.runtimeType) {
        case result_data.Success:
          categoriesList =
              (responseResult as result_data.Success<dynamic>).data;
          notifyListeners();
          break;
        case result_data.Error:
          _errorMessage =
              (responseResult as result_data.Error<dynamic>).msg as String;
          break;
      }
      disableCategoriesLoading();

  }

  void getAllProducts() async {
      clearErrorMessage();
      enableProductsLoading();
      var responseResult = await _repo.getAllProducts(token);
      switch (responseResult.runtimeType) {
        case result_data.Success:
          productsList = (responseResult as result_data.Success<dynamic>).data;
          break;
        case result_data.Error:
          _errorMessage =
              (responseResult as result_data.Error<dynamic>).msg as String;
          break;
      }
      disableProductsLoading();
  }

  void getProductsByCategoryName(String categoryName) async {
      clearErrorMessage();
      enableProductsLoading();
      var responseResult =
          await _repo.getProductsByCategoryName(token, categoryName);
      switch (responseResult.runtimeType) {
        case result_data.Success:
          productsList = (responseResult as result_data.Success<dynamic>).data;
          break;
        case result_data.Error:
          _errorMessage =
              (responseResult as result_data.Error<dynamic>).msg as String;
          break;
      }
      disableProductsLoading();

  }

  void searchForProduct(String keyword) {
    //todo: search for products on the data list and updated the shown data

    notifyListeners();
  }

  void enableProductsLoading() {
    _isProductsLoading = true;
    notifyListeners();
  }

  void disableProductsLoading() {
    _isProductsLoading = false;
    notifyListeners();
  }

  void enableCategoriesLoading() {
    _isCategoriesLoading = true;
    notifyListeners();
  }

  void disableCategoriesLoading() {
    _isCategoriesLoading = false;
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

  Product getProductByIndex(int index) => (productsList?[index])!;

  String getCategoryByIndex(int index) => (index < 0) ? 'All' : (categoriesList?[index])!;

  bool isCategorySelected(int index) => (index == selectedCategoryIndex);

  void setCategorySelected(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
    if(selectedCategoryIndex<0){
      getAllProducts();
    }else{
      getProductsByCategoryName(getCategoryByIndex(index));
    }
  }

  int getNumOfCategories() => (categoriesList?.length)!;

  int getNumOfProducts() => (productsList?.length)!;

}
