import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/app_colors.dart';
import 'package:mvvm_provider/res/components/round_button.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/viewModel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _changePasswordVisibility =
      ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _emailNode.dispose();
    _passwordNode.dispose();

    _changePasswordVisibility.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
          style: TextStyle(color: AppColors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: _emailNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25))),
              onFieldSubmitted: (value) {
                Utils.changeFocusNode(context, _emailNode, _passwordNode);
              },
            ),
            SizedBox(
              height: height * .05,
            ),
            ValueListenableBuilder(
              valueListenable: _changePasswordVisibility,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  obscureText: _changePasswordVisibility.value,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            _changePasswordVisibility.value =
                                !_changePasswordVisibility.value;
                          },
                          child: Icon(
                            _changePasswordVisibility.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.grey,
                          ))),
                );
              },
            ),
            SizedBox(
              height: height * .1,
            ),
            RoundButton(
              text: "Sign Up",
              loading: authViewModel.signUpLoading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter email", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please enter password", context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      "Password must have 6 digit", context);
                } else {
                  // Utils.flushBarErrorMessage("Api hit", context);
                  Map data = {
                    "email": _emailController.text.trim(),
                    "password": _passwordController.text.trim(),
                  };
                  authViewModel.signUpApi(data, context);
                }
              },
            ),
            SizedBox(
              height: height * .1,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.login);
              },
              child: const Text("Already have an account? SignIn"),
            )
          ],
        ),
      ),
    );
  }
}
