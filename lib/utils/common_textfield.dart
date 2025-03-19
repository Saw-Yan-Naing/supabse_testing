import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String obscuringCharacter;
  final Widget? suffix;
  final double width;
  final bool obscureText;

  const CommonTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.obscuringCharacter = "*",
    this.suffix,
    this.width = 300,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffix: suffix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        obscuringCharacter: obscuringCharacter,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}
