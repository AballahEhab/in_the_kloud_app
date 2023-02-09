import 'package:http/http.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/HttpRequest.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';

class ProductsService {

  Future<Response> getAllCategories(String tokenValue) async => EndPointRequest(
          endPoint: EndPoint(path: '/products/categories'),
          headers: {AppStrings.tokenKey: AppStrings.tokenPrefix+tokenValue},
          requestMethod: HttpRequestMethod.GET)
      .proceedWithRequest();

  Future<Response> getProductsByCategoryName(
          String tokenValue, String categoryName) async =>
      EndPointRequest(
              endPoint: EndPoint(path: '/products/category/$categoryName'),
              headers: {AppStrings.tokenKey: AppStrings.tokenPrefix+tokenValue},
              requestMethod: HttpRequestMethod.GET)
          .proceedWithRequest();

  Future<Response> getAllProducts(String tokenValue) async => EndPointRequest(
          endPoint: EndPoint(path: '/products'),
          headers: {AppStrings.tokenKey: AppStrings.tokenPrefix+tokenValue},
          requestMethod: HttpRequestMethod.GET)
      .proceedWithRequest();
}
