import 'package:http/http.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/HttpRequest.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';

class ProductsDetailsService {

  Future<Response> getProductsById(
          String tokenValue, int productId) async =>
      EndPointRequest(
              endPoint: EndPoint(path: '/products/$productId'),
              headers: {AppStrings.tokenKey: AppStrings.tokenPrefix+tokenValue},
              requestMethod: HttpRequestMethod.GET)
          .proceedWithRequest();

}
