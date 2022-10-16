import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart';
import 'package:in_the_kloud_app/features/login/data_source/remote/authentication_service.dart';
import 'package:in_the_kloud_app/features/login/models/user_data_model.dart';
import 'package:in_the_kloud_app/features/login/models/user_login_model.dart';

class LoginRepository  {
  final AuthenticationService _authService = AuthenticationService();

  Future<ResultData> login(UserLoginModel userCredentials) async {
    try {
      var response = await _authService.login(userCredentials);
      if(response.statusCode == 200) {
        var responseBody = await compute<Map<String, dynamic>, UserDataModel>(
            UserDataModel.fromJson, jsonDecode(response.body));
        return ResultData.success(responseBody);
      }else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }

    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }

  }
}
