import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/view/login_screen.dart';

import '../../view/home_screen.dart';
import '../../view/signUp_screen.dart';

class Routes{

  static Route<dynamic> generateRoutes(RouteSettings setting){
    switch(setting.name){
      case (RouteNames.login):
        return  MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case (RouteNames.home):
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),);
      case (RouteNames.signUp):
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignUpScreen(),);
      default:
       return  MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text("No route define"),
          ),
        );
      },);
    }
  }

}