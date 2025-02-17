import 'package:flutter/material.dart';

class AuthFields extends StatelessWidget {
  final String hintText;
  final bool pass;
  final TextEditingController controller;

  const AuthFields({
    super.key,
    required this.hintText,
    this.pass = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: pass,
      //keyboardType: pass ? TextInputType.visiblePassword : TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
