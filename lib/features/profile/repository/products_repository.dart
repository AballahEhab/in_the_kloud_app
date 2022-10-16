import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart';
import 'package:in_the_kloud_app/features/home/data_source/remote/products_Service.dart';
import 'package:in_the_kloud_app/features/home/models/products_data_model.dart';
import 'package:in_the_kloud_app/features/profile/data_source/remote/products_service.dart';
import 'package:in_the_kloud_app/features/profile/models/detailed_user_data.dart';

class UserProfileRepository {
  final UserProfileService _userProfileService = UserProfileService();

  Future<ResultData> getDetailedUserDataById(int userId, String tokenValue) async {
    try {
      var response = await _userProfileService.getDetailedUserDataById(userId,tokenValue);
      if (response.statusCode == 200) {
        DetailedUserData responseBodyObj = DetailedUserData.fromJson(jsonDecode(response.body));
        return ResultData.success(responseBodyObj);
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        return ResultData.error(errorMessage);
      }
    } on Exception catch (exception) {
      return ResultData.error(exception.toString());
    }
  }

  Future<ResultData> updateUserData(
      String tokenValue, DetailedUserData userData) async {
    try {
      var response = await _userProfileService.updateUserData(
          tokenValue, userData);
      if (response.statusCode == 200) {
        DetailedUserData responseBodyObj = DetailedUserData.fromJson(jsonDecode(response.body));
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
