import 'dart:async';

import 'package:car_parking/constants/snackbar.dart';
import 'package:car_parking/providers/auth_providers.dart';
import 'package:car_parking/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpController = TextEditingController();
  bool _resend = false;

  @override
  void initState() {
    super.initState();
    resend();
  }

  void resend() {
    Future.delayed(const Duration(seconds: 60), () {
      setState(() {
        _resend = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (BuildContext context, _auth, Widget? child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Hero(
                  tag: "logo",
                  child: Logo(),
                ),
                const SizedBox(height: 100),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  textStyle: const TextStyle(color: Colors.black, fontSize: 20),
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  controller: _otpController,
                  onCompleted: (v) {
                    if (v.length == 6) {
                      _auth.verifyOtp(
                          context: context, otp: _otpController.text);
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 6) {
                      _auth.verifyOtp(
                          context: context, otp: _otpController.text);
                    }
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (!_resend) {
                          showtoast(
                            context,
                            "Resend Otp available after 60 sec",
                            Colors.green,
                          );
                        } else {
                          AuthProvider().sendOtp(
                            context: context,
                            phone: "",
                          );
                          showtoast(
                            context,
                            "OTP resend successfully",
                            Colors.green,
                          );
                          resend();
                          setState(() {
                            _resend = false;
                          });
                        }
                      },
                      child: const Text("Resend OTP"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (_otpController.text.isNotEmpty) {
                      if (_otpController.text.length == 6) {
                        _auth.verifyOtp(
                          context: context,
                          otp: _otpController.text,
                        );
                      } else {
                        showtoast(context, "Enter Valid Otp", Colors.red);
                      }
                    } else {
                      showtoast(context, "Enter Otp", Colors.red);
                    }
                  },
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  textColor: Colors.white,
                  color: const Color(0xff613EEA),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
