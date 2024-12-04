import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/app_colors.dart';
import 'package:mvvm_provider/res/components/round_button.dart';
import 'package:mvvm_provider/utils/routes/route_names.dart';
import 'package:mvvm_provider/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title:  Text("Login",style: TextStyle(color: AppColors.white),),
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
            RoundButton(text: "Login", onPress: () {
               if(_emailController.text.isEmpty){
                 Utils.flushBarErrorMessage("Please enter email", context);
               }else if(_passwordController.text.isEmpty){
                 Utils.flushBarErrorMessage("Please enter password", context);
               }else if(_passwordController.text.length < 6){
                 Utils.flushBarErrorMessage("Password must have 6 digit", context);
               }else{
                 Utils.flushBarErrorMessage("Api hit", context);
               }
            },)

          ],
        ),
      ),
    );
  }
}
