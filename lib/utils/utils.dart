import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{


  static showToast(String message){
    Fluttertoast.showToast(msg: message,
    backgroundColor: Colors.grey,
      textColor: Colors.white,

    );
  }


  static void showFlushBarError(String message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          title: message,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
          padding: const EdgeInsets.all(10),
          icon: const Icon(Icons.error,color: Colors.white,size: 28,),

        )..show(context)
    );
  }



}