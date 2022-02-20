import 'package:flutter/material.dart';

void showtoast(BuildContext context, String msg, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(msg),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    ),
  );
}
