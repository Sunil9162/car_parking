import 'package:car_parking/constants/show_spinner.dart';
import 'package:car_parking/constants/snackbar.dart';
import 'package:car_parking/providers/auth_providers.dart';
import 'package:car_parking/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'otp_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
              TextField(
                keyboardType: TextInputType.number,
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Consumer<AuthProvider>(
                builder: (BuildContext context, _auth, Widget? child) =>
                    MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (_numberController.text.isNotEmpty) {
                      if (_numberController.text.length == 10) {
                        _auth.sendOtp(
                          context: context,
                          phone: _numberController.text,
                        );
                      } else {
                        showtoast(context, "Invalid Phone Number", Colors.red);
                      }
                    } else {
                      showtoast(context, "Enter the Phone Number", Colors.red);
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
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('or Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
