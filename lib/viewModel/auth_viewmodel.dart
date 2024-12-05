import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/model/user_model.dart';
import 'package:mvvm_provider/repository/auth_repository.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/viewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/routes/route_names.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loading = false;
  bool _signUpLoading = false;

  get loading => _loading;
  get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _auth.signIn(data).then(
      (value) {
        log(value.toString());
        setLoading(false);
        final userPreference = Provider.of<UserViewModel>(context,listen: false);
        userPreference.saveUser(UserModel(token: value["token"].toString()));
        Utils.flushBarErrorMessage("Login successfully", context);

        Navigator.pushNamed(context, RouteNames.home);
      },
    ).onError(
      (error, stackTrace) {
        Utils.flushBarErrorMessage(error.toString(), context);

        setLoading(false);
      },
    );
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _auth.signUp(data).then(
      (value) {
        log(value.toString());
        setSignUpLoading(false);


        final userPreference = Provider.of<UserViewModel>(context,listen: false);
        userPreference.saveUser(UserModel(token: value["token"].toString()));

        Utils.flushBarErrorMessage("Create account successfully", context);

        Navigator.pushNamed(context, RouteNames.home);
      },
    ).onError(
      (error, stackTrace) {
        Utils.flushBarErrorMessage(error.toString(), context);

        setSignUpLoading(false);
      },
    );
  }
}
