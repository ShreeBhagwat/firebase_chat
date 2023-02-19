import 'package:firebase_chat/constants.dart';
import 'package:firebase_chat/helper.dart';
import 'package:flutter/material.dart';

extension BuildContextExtention on BuildContext {
  void navigateToScreen({required Widget screen, bool isReplace = false}) {
    if (isReplace) {
      Navigator.pushAndRemoveUntil(
          this, MaterialPageRoute(builder: (_) => screen), (route) => false);
    } else {
      Navigator.push(
        this,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  double getHeight(double percent) {
    return MediaQuery.of(this).size.height * percent;
  }

  double getWidth(double percent) {
    return MediaQuery.of(this).size.width * percent;
  }

  void showCustomSnackbar({
    required String title,
    required String message,
    required MessageType messageType,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor:
            Helpers.getSnackbarBgColour(this, messageType: messageType),
        content: SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                    padding: EdgeInsets.all(8.0), child: SizedBox.shrink()),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: kTitleTextStyle,
                  ),
                  Text(
                    message,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
