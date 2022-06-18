// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:restroapp/constants/constants.dart';
import 'package:restroapp/constants/utils.dart';
import 'package:restroapp/screens/homescreen.dart';
import 'package:restroapp/screens/login_screen.dart';
import 'package:restroapp/services/auth.dart';
import 'package:restroapp/widgets/bottom_navigationbar.dart';
import 'package:restroapp/widgets/custom_formfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String id = '/SignUp';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 230,
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
                          controller: _nameController,
                          textInputType: TextInputType.name,
                          hintText: 'Name'),
                      kHeightSpacer(10.0),
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
                      kHeightSpacer(10.0),
                      CustomFormField(
                        controller: _mobileController,
                        textInputType: TextInputType.number,
                        hintText: 'Mobile',
                      ),
                      kHeightSpacer(10.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          var message = await SignIn().signUpUser(
                              email: _emailController.text,
                              pass: _passwordController.text,
                              name: _nameController.text,
                              phone: _mobileController.text);
                          if (message == 'Success') {
                            showSnackBar(context,
                                'Account Created Successfully', Colors.green);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyBottomNavigationBar.id, (route) => false);
                          } else {
                            showSnackBar(context, message, Colors.red);
                          }
                        },
                        child: const Text('SignUp'),
                      ),
                    ],
                  ),
                ),
              ),
              kHeightSpacer(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have and account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: const Text(
                      'Login',
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
