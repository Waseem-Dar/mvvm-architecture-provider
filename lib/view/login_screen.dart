import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:mvvm_provider/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
   State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbqar"),),
      body: Center(
        child: InkWell(
            onTap: () {
              Utils.showFlushBarError("No intrnet connection", context);
              // Utils.showToast("No internet connection");
              // Navigator.pushNamed(context, RouteNames.home);
            },
            child:  const Text("click")),
      ),
    );
  }
}
