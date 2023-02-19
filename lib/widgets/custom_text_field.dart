import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validatorFunction;
  final IconData icon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validatorFunction,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: validatorFunction,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.blueAccent,
          ),
          hintText: hintText,
          hintStyle: kSubtitleTextStyle,
          border: kTextFieldBorder,
          focusedBorder: kTextFieldFocusedBorder,
          errorBorder: kTextFieldErrorBorder,
        ),
      ),
    );
  }
}
