import 'package:flutter/material.dart';
import 'package:insurance_app/Util/colors.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.icon,
    required this.isPassword,
    required this.text,
    required this.textInputType,
    required this.validator,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;
  final String text;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.isPassword,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 239, 239, 239),
        filled: true,
        hintText: widget.text,
        prefixIcon: Icon(widget.icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.btnBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: widget.validator,
    );
  }
}
