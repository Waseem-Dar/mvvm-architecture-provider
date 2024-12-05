import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/model/user_model.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:mvvm_provider/viewModel/user_viewmodel.dart';

class SplashService {
  Future<UserModel> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    getUserData().then(
      (value) async {
        log(value.token.toString());
        print(value.token);
        if (value.token == "null" || value.token == "") {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushNamed(context, RouteNames.login);
        } else {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushNamed(context, RouteNames.home);
        }
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
      },
    );
  }
}
