import 'package:http/http.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/HttpRequest.dart';
import 'package:in_the_kloud_app/features/profile/models/detailed_user_data.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';

class UserProfileService {

  Future<Response> getDetailedUserDataById(int userId, String tokenValue) async => WebApiRequest(
          endPoint: EndPoint(path: '/users/$userId'),
          headers: {AppStrings.tokenKey: AppStrings.tokenPrefix + tokenValue},
          requestMethod: HttpRequestMethod.GET)
      .proceedWithRequest();

  Future<Response> updateUserData(
          String tokenValue, DetailedUserData userData) async =>
      WebApiRequest(
  endPoint: EndPoint(path: '/users/${userData.id}'),
  body: userData.toJson(),
  requestMethod: HttpRequestMethod.PUT)
      .proceedWithRequest();



}
