import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
    );
  }
}
