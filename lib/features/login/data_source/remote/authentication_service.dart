import 'package:http/http.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/HttpRequest.dart';
import 'package:in_the_kloud_app/features/login/models/user_login_model.dart';

class AuthenticationService {

   Future<Response> login(UserLoginModel userLogin) async => WebApiRequest(
          endPoint: EndPoint(path: '/auth/login'),
          body: userLogin.toJson(),
          requestMethod: HttpRequestMethod.POST)
      .proceedWithRequest();


}
