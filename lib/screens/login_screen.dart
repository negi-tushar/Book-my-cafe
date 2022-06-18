// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:restroapp/constants/utils.dart';
import 'package:restroapp/screens/signup_screen.dart';
import 'package:restroapp/services/auth.dart';
import 'package:restroapp/widgets/custom_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = '/Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 250,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                // height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'Email'),
                      kHeightSpacer(10.0),
                      CustomFormField(
                        controller: _passwordController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Password',
                        isPass: true,
                      ),
                      kHeightSpacer(10),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          var message = await SignIn().signInWithEmailPass(
                              email: _emailController.text,
                              pass: _passwordController.text);
                          if (message == 'Success') {
                            showSnackBar(
                                context, 'LoggedIn Successfully', Colors.green);
                          } else {
                            showSnackBar(context, message, Colors.red);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text('OR'),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 140,
                    height: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var message = await SignIn().googleSignIn();
                      if (message == 'Success') {
                        showSnackBar(
                            context, 'Logged In Successfully', Colors.green);
                      } else {
                        showSnackBar(context, message, Colors.red);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/Google.png'))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Facebook.png'))),
                  ),
                ],
              )),
              kHeightSpacer(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have and account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
