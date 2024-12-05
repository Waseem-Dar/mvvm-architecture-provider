import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/app_colors.dart';
import 'package:mvvm_provider/viewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/routes/route_names.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return  Scaffold(
      appBar: AppBar(
        title:  Text("Home",style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.blue,
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          TextButton.icon(
              onPressed: (){
                userViewModel.removeUser().then((value) {
                  Navigator.pushNamed(context, RouteNames.login);
                },);
              },
              label: Text("LogOut",style: TextStyle(color: AppColors.white),),
            icon: Icon(Icons.logout,color: AppColors.white,size: 28,),
          )
        ],
      ),
      body: Center(
        child: 
        Text("Home screen"),
      ),
    );
  }
}
