import 'package:flutter/material.dart';

void showSpinner(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const CircularProgressIndicator(),
              const SizedBox(
                width: 10,
              ),
              Text(message),
            ],
          ),
        ),
      );
    },
  );
}
