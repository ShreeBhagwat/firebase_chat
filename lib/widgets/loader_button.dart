import 'package:firebase_chat/constants.dart';
import 'package:firebase_chat/extensions/build_context_extentions.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final bool? isLoading;
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color? color;
  const LoaderButton({
    super.key,
    this.isLoading,
    required this.buttonTitle,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.blueAccent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: context.getWidth(0.8),
        height: 50,
        child: Center(
          child: isLoading ?? false
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(buttonTitle,
                  style: kButtonTextStyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
