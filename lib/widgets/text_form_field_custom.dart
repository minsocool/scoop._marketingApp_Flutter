import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final VoidCallback? onTap;
  final bool chooseStyle;
  final bool suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  TextFormFieldCustom({
    required this.chooseStyle,
    required this.hintText,
    this.icon,
    this.suffixIcon = false,
    this.obscureText = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.left,
  });
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return chooseStyle
        ? _roundedTextFormField(_height, _width)
        : _noRoudedTextFormField(_height);
  }

  Widget _roundedTextFormField(double height, double width) => TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: chooseStyle ? true : false,
          fillColor: chooseStyle ? Colors.grey.shade200 : null,
          contentPadding: EdgeInsets.only(
              left: width * 0.04, top: height * 0.025, bottom: height * 0.025),
          prefixIcon: icon,
          errorStyle: TextStyle(
            fontSize: 13,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon
              ? GestureDetector(
                  onTap: onTap,
                  child: obscureText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      );
  Widget _noRoudedTextFormField(double height) => TextFormField(
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        textAlign: textAlign,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: height * 0.025, bottom: height * 0.025),
          icon: icon,
          errorStyle: TextStyle(
            fontSize: 13,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon
              ? GestureDetector(
                  onTap: onTap,
                  child: obscureText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : null,
        ),
      );
}
