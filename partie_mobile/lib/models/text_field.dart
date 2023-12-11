import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.icon})
      : super(key: key);

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: icon,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0XFF003869),
          ),
        ),
      ),
    );
  }
}
