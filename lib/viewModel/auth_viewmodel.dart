import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/repository/auth_repository.dart';
import 'package:mvvm_provider/utils/utils.dart';

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
        setLoading(false);

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
        setSignUpLoading(false);

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
