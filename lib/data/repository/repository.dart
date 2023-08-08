import 'dart:convert';

import 'package:hotsale_test/domain/user_details_model.dart';
import 'package:hotsale_test/domain/user_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repository {

  Future<UserModel?> getListUsers(int page) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    try {
      UserModel? userModel;
      http.Response response = await http.get(
        Uri.tryParse(
            'https://reqres.in/api/users?page=$page')!,
      );
      if (response.statusCode == 200) {
        if(page == 1) {
          userModel = UserModel.fromJson(jsonDecode(response.body));
          final userModelValue = json.encode(userModel);
          await sharedPrefs.setString(
            "userModel",
            userModelValue,
          );
        } else if(page == 2) {
          final userList = sharedPrefs.getString("userModel");
          userModel = UserModel.fromJson(jsonDecode(response.body));
          final updatedUserModel = UserModel.fromJson(jsonDecode(userList!))
            ..data.addAll(userModel.data);
          final userModelValue = json.encode(updatedUserModel);
          await sharedPrefs.setString(
            "userModel",
            userModelValue,
          );
        }
      }
      return userModel;
    } catch (e) {
      var body = sharedPrefs.getString("userModel");
      var userModel = json.decode(body!);
      UserModel model = UserModel.fromJson(userModel);
      return model;
    }
  }

  Future getUserInfo(int userId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(
        Uri.tryParse('https://reqres.in/api/users/$userId')!,
      );
      if (response.statusCode == 200) {
        UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(jsonDecode(response.body));
        String userModelDetailsKey = json.encode(userDetailsModel);
        sharedPrefs.setString("userDetailsModel", userModelDetailsKey);
        return userDetailsModel;
      }
    } catch (e) {
      var body = sharedPrefs.getString("userDetailsModel");
      var userDetailsModel = json.decode(body!);
      UserDetailsModel model = UserDetailsModel.fromJson(userDetailsModel);
      return model;
    }
  }
}
