import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart'
    as result_data;
import 'package:in_the_kloud_app/features/login/models/user_data_model.dart';
import 'package:in_the_kloud_app/features/login/models/user_login_model.dart';
import 'package:in_the_kloud_app/features/login/repository/login_repository.dart';

class LogInProvider extends ChangeNotifier {
  final LoginRepository _repo = LoginRepository();

  ValueNotifier<UserDataModel?> userData = ValueNotifier(null);

  String userName = '';
  String password = '';

  bool _credentialsValid = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> login() async {
    if (!_isLoading) {
      _validateCredentials();
      if (_credentialsValid) {
        clearErrorMessage();
        enableLoading();
        var responseResult = await _repo
            .login(UserLoginModel(username: userName, password: password));
        switch (responseResult.runtimeType) {
          case result_data.Success:
            userData.value = (responseResult as result_data.Success<dynamic>)
                .data as dynamic;
            break;
          case result_data.Error:
            _errorMessage =
                (responseResult as result_data.Error<dynamic>).msg as String;
            break;
        }
        disableLoading();
      } else {
        errorMessage = 'invalid credentials ';
      }
    }
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

  void _validateCredentials() {
    _credentialsValid = userName.isNotEmpty && password.isNotEmpty;
  }
}
