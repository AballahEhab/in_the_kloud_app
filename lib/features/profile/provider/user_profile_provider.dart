import 'package:flutter/foundation.dart';
import 'package:in_the_kloud_app/core/base/http_server_requests/ResultData.dart'
    as result_data;
import 'package:in_the_kloud_app/features/profile/models/detailed_user_data.dart';
import 'package:in_the_kloud_app/features/profile/repository/products_repository.dart';
import 'package:in_the_kloud_app/resources/strings.dart';

class UserProfileProvider extends ChangeNotifier {
  final UserProfileRepository _repo = UserProfileRepository();

  UserProfileProvider(this.token, this.userId);

  final String token;

  final int userId;

  int? _selectedGenderIndex;

  set selectedGenderIndex(int genderIndex) {
    _selectedGenderIndex = genderIndex;
    notifyListeners();
  }

  int get selectedGenderIndex => _selectedGenderIndex!;

  DetailedUserData? _userData;

  bool editModeEnabled = false;

  String firstName = '';
  String midName = '';
  String address = '';
  String phone = '';
  String gender = '';

  set userData(DetailedUserData data) {
    selectedGenderIndex = AppStrings.genders.indexOf(data.gender!);
    _userData = data;
  }

  DetailedUserData get userData => _userData!;

  bool userDataLoading = true;

  bool saveDataLoading = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void getUserData() async {
    clearErrorMessage();
    enableLoading();
    var responseResult = await _repo.getDetailedUserDataById(userId, token);
    switch (responseResult.runtimeType) {
      case result_data.Success:
        userData = (responseResult as result_data.Success<dynamic>).data;
        break;
      case result_data.Error:
        _errorMessage =
            (responseResult as result_data.Error<dynamic>).msg as String;
        break;
    }
    disableLoading();
  }

  void updateUserData() async {
    clearErrorMessage();
    enableSaveDataLoadingIndicator();
    var responseResult = await _repo.updateUserData(
      token,
      DetailedUserData(
          firstName: firstName,
          maidenName: midName,
          address: Address(address: address),
          phone: phone,
          gender: AppStrings.genders[selectedGenderIndex]),
    );
    switch (responseResult.runtimeType) {
      case result_data.Success:
        userData = (responseResult as result_data.Success<dynamic>).data;
        break;
      case result_data.Error:
        _errorMessage =
            (responseResult as result_data.Error<dynamic>).msg as String;
        break;
    }
    disableEditing();
    disableSaveDataLoadingIndicator();
  }

  void enableSaveDataLoadingIndicator() {
    saveDataLoading = true;
    notifyListeners();
  }
  void disableSaveDataLoadingIndicator() {
    saveDataLoading = false;
    notifyListeners();
  }

  void disableLoading() {
    userDataLoading = false;
    notifyListeners();
  }

  void enableLoading() {
    userDataLoading = true;
    notifyListeners();
  }

  void enableEditing() {
    editModeEnabled = true;
    notifyListeners();
  }

  void disableEditing() {
    editModeEnabled = false;
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

}
