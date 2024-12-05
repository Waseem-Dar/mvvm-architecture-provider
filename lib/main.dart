import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:mvvm_provider/utils/routes/routes.dart';
import 'package:mvvm_provider/viewModel/auth_viewmodel.dart';
import 'package:mvvm_provider/viewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel(),),
      ChangeNotifierProvider(create: (_) => UserViewModel(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.splash,
      onGenerateRoute: Routes.generateRoutes,
    ),
    );
  }
}
