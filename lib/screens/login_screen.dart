// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab1/components/button_component.dart';
import 'package:firebase_lab1/components/icon_broken.dart';
import 'package:firebase_lab1/components/snackBar_component.dart';
import 'package:firebase_lab1/components/text_form_component.dart';
import 'package:firebase_lab1/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          physics: ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding:
                EdgeInsetsDirectional.symmetric(vertical: 70, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: const TextStyle(
                    fontFamily: 'EduSABeginner',
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Image.asset(
                  'assets/images/social.png',
                  height: 170,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '       Please Enter valid Email Address';
                    }
                    return null;
                  },
                  prefixIcon: IconBroken.Message,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormFieldComponent(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  label: 'Password',
                  prefixIcon: IconBroken.Password,
                  suffixIcon: _obscureText ? IconBroken.Show : IconBroken.Hide,
                  suffixOnPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Password';
                    }
                    if (value.length < 6) {
                      return '       Please Enter Password more than 6';
                    }
                    return null;
                  },
                  onFiledSubmitted: (value) {
                    if (formKey.currentState!.validate()) {
                      print(emailController.text);
                      login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButtonComponent(
                  text: 'Login',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print(emailController.text);
                      login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t you have an account ?',
                      style: TextStyle(
                        fontFamily: 'EduSABeginner',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          fontFamily: 'EduSABeginner',
                          fontWeight: FontWeight.w900,
                          color: Colors.indigo,
                          fontSize: 13,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login({String? email, String? password, context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'homeScreen', (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        showSnackBar(
          context,
          'No user found or Wrong Password . Please check your Email and Password.',
          Colors.red,
        );
      } else if (e.code == 'too-many-requests') {
        showSnackBar(
          context,
          '''Many failed login attempts 
          Please Closing App and Try Again''',
          Colors.red,
        );
      }
    }
  }
}
