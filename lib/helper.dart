import 'package:flutter/material.dart';

enum MessageType {
  info,
  success,
  warning,
  error,
}

class Helpers {
  static Color getSnackbarBgColour(BuildContext context,
      {required MessageType messageType}) {
    switch (messageType) {
      case MessageType.info:
        return Colors.amber;

      case MessageType.success:
        return Colors.greenAccent;

      case MessageType.warning:
        return Colors.blueAccent;
      case MessageType.error:
        return Colors.redAccent;
    }
  }
}
