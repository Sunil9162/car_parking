import 'package:car_parking/constants/show_spinner.dart';
import 'package:car_parking/constants/snackbar.dart';
import 'package:car_parking/models/user_model.dart';
import 'package:car_parking/providers/auth_providers.dart';
import 'package:car_parking/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPassWordPage extends StatefulWidget {
  const AddPassWordPage({Key? key}) : super(key: key);

  @override
  _AddPassWordPageState createState() => _AddPassWordPageState();
}

class _AddPassWordPageState extends State<AddPassWordPage> {
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSecure = true;
  final user = FirebaseAuth.instance.currentUser;

  bool validate() {
    if (_nameController.text.isEmpty) {
      showtoast(context, 'Please enter your name', Colors.red);
      return false;
    }
    if (_passwordController.text.isEmpty) {
      showtoast(context, 'Please enter your password', Colors.red);
      return false;
    }
    if (_confirmPasswordController.text.isEmpty) {
      showtoast(context, 'Please enter your confirm password', Colors.red);
      return false;
    }
    if (_passwordController.text.length < 6) {
      showtoast(context, 'Password must be at least 6 characters', Colors.red);
      return false;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      showtoast(context, 'Password does not match', Colors.red);
      return false;
    }
    return true;
  }

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
              const SizedBox(height: 50),
              TextField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                obscureText: isSecure,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  labelText: 'Confirm Password',
                  suffix: IconButton(
                    icon: Icon(
                      isSecure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isSecure = !isSecure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Consumer<AuthProvider>(
                builder: (BuildContext context, _auth, Widget? child) =>
                    MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (validate()) {
                      showSpinner(context, "Setting up your account");
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user!.uid)
                          .set(
                            UserModel(
                              uid: user!.uid,
                              number: _auth.phoneNumber,
                              password: _passwordController.text,
                              name: _nameController.text,
                            ).toJson(),
                          );
                      Navigator.pop(context);
                      AuthProvider().setlogin(true, _auth.phoneNumber);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    } else {
                      showtoast(context, "Password not Matched", Colors.red);
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
