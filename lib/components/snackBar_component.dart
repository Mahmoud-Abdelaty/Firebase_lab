import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String? message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message!,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'EduSABeginner',
        fontWeight: FontWeight.w900,
        color: Colors.black,
        fontSize: 15,
      ),
    )),
    backgroundColor: color,
    duration: const Duration(milliseconds: 3000),
  ));
}
