import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab1/components/button_component.dart';
import 'package:firebase_lab1/components/icon_broken.dart';
import 'package:firebase_lab1/components/snackBar_component.dart';
import 'package:firebase_lab1/components/text_form_component.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          physics: const ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 50, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'EduSABeginner',
                    fontWeight: FontWeight.w900,
                    color: Colors.indigo,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/social.png',
                  height: 170,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormFieldComponent(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: 'Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '       Please Enter Your Name';
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: IconBroken.Profile,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldComponent(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  label: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '       Please Enter valid Email Address\n       exmaple@example.com';
                    }
                    return null;
                  },
                  prefixIcon: IconBroken.Message,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldComponent(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  label: 'Phone',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '       Please Enter valid Email Address\n       exmaple@example.com';
                    }
                    return null;
                  },
                  prefixIcon: IconBroken.Call,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldComponent(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  label: 'Password',
                  prefixIcon: IconBroken.Password,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '       Please Enter Password';
                    }
                    if (value.length < 6) {
                      return '       Please Enter Password more than 6';
                    }
                    return null;
                  },
                  suffixIcon: _obscureText ? IconBroken.Show : IconBroken.Hide,
                  suffixOnPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  onFiledSubmitted: (value) {
                    if (formKey.currentState!.validate()) {
                      register(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                        context: context,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButtonComponent(
                  text: 'Register',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      register(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                        context: context,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you have an account ?',
                      style: TextStyle(
                          fontFamily: 'EduSABeginner',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    TextButton(
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                            fontFamily: 'EduSABeginner',
                            fontWeight: FontWeight.w900,
                            color: Colors.indigo,
                            fontSize: 13),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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

  Future<void> register(
      {String? name, String? email, String? password, phone, context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'UId': FirebaseAuth.instance.currentUser!.uid,
          'name': name,
          'email': email,
          'password': password,
          'phone': '0$phone',
        });
        Navigator.pushNamedAndRemoveUntil(
            context, 'homeScreen', (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(
          context,
          'The Password provided is too Weak',
          Colors.red,
        );
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          'The Account already exists for that Email',
          Colors.red,
        );
      }
    }
  }
}
