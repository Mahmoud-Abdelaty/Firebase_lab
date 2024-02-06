import 'package:flutter/material.dart';

class MaterialButtonComponent extends StatelessWidget {
  MaterialButtonComponent({
    super.key,
    required this.text,
    this.onPressed,
  });

  String text;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.indigo,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'EduSABeginner',
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
