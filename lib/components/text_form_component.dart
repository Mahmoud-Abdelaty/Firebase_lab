import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  TextFormFieldComponent({
    super.key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.onTap,
    required this.label,
    this.labelStyle,
    this.obscureText = false,
    this.onFiledSubmitted,
    this.prefixIcon,
    this.style,
    this.suffixIcon,
    this.suffixOnPressed,
  });
  TextEditingController? controller;
  TextInputType? keyboardType;
  String label;
  TextStyle? labelStyle;
  TextStyle? style;
  IconData? prefixIcon;
  IconData? suffixIcon;
  ValueChanged<dynamic>? onFiledSubmitted;
  ValueChanged? onChanged;
  FormFieldValidator<String>? validator;
  bool obscureText;
  VoidCallback? suffixOnPressed;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      style: const TextStyle(
        fontFamily: 'EduSABeginner',
        fontWeight: FontWeight.w900,
        decoration: TextDecoration.none,
        fontSize: 16,
      ),
      onFieldSubmitted: onFiledSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsetsDirectional.only(
            start: 20, end: 20, top: 15, bottom: 15),
        counterText: '',
        counterStyle: const TextStyle(fontSize: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.indigo,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 2, color: Colors.indigo),
        ),
        errorStyle: TextStyle(
            fontFamily: 'EduSABeginner',
            fontWeight: FontWeight.w900,
            color: Colors.red[900],
            fontSize: 13),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.shade900,
          ),
        ),
        label: Text(
          label,
          style: const TextStyle(
              fontFamily: 'EduSABeginner',
              fontWeight: FontWeight.w900,
              fontSize: 13),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: suffixOnPressed,
              )
            : null,
      ),
    );
  }
}
