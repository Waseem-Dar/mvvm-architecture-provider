import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/app_colors.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({super.key, required this.text,  this.loading = false, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius:  BorderRadius.circular(30)
        ),
        child: Center(
          child:loading?CircularProgressIndicator(color: AppColors.white,): Text(text,style: TextStyle(color: AppColors.white,fontSize: 17),),
        ),
      ),
    );
  }
}
