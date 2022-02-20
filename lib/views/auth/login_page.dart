import 'package:car_parking/constants/snackbar.dart';
import 'package:car_parking/providers/auth_providers.dart';
import 'package:car_parking/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSecure = true;

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
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: isSecure,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  labelText: 'Password',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Consumer<AuthProvider>(
                builder: (BuildContext context, _auth, Widget? child) =>
                    MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (_numberController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      showtoast(
                        context,
                        "Please fill all credentials",
                        Colors.red,
                      );
                      return;
                    } else {
                      _auth.login(
                        context,
                        _numberController.text,
                        _passwordController.text,
                      );
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
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: const Text('or Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
