import 'package:car_parking/constants/show_spinner.dart';
import 'package:car_parking/constants/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSending = false;
  bool get isSending => _isSending;
  final _auth = FirebaseAuth.instance;
  String verificationid = "";
  String phoneNumber = "";

  void setSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  Future<void> setlogin(bool login, String number) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", login);
    prefs.setString("number", number);
  }

  Future<void> sendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    phoneNumber = phone == "" ? phoneNumber : phone;
    setSending(true);
    showSpinner(context, "Verifying...");
    await FirebaseFirestore.instance
        .collection("Users")
        .where("number", isEqualTo: phoneNumber)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        showtoast(context, "Mobile Number Already Registered", Colors.red);
        return;
      } else {
        await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: "+91" + phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            showtoast(context, e.message.toString(), Colors.red);
            Navigator.pop(context);
          },
          codeSent: (String verificationId, int? resendToken) {
            setSending(false);
            Navigator.pop(context);
            verificationid = verificationId;
            if (phone != "") {
              Navigator.pushNamed(
                context,
                '/otp',
              );
            }
            notifyListeners();
            showtoast(context, "Otp has been sent to your Number", Colors.blue);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    });

    setSending(false);
    notifyListeners();
  }

  Future<void> verifyOtp({
    required BuildContext context,
    required String otp,
  }) async {
    setSending(true);
    showSpinner(context, "Verifying OTP...");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationid,
      smsCode: otp,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      if (value.user != null) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/addpassword');
        return;
      } else {
        Navigator.pop(context);
        showtoast(context, "Error while Signing In", Colors.red);
        return;
      }
    });

    setSending(false);
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    setlogin(false, "");
  }

  // Login

  Future<void> login(
    BuildContext context,
    String number,
    String password,
  ) async {
    setSending(true);
    showSpinner(context, "Logging in...");
    await FirebaseFirestore.instance
        .collection("Users")
        .where("number", isEqualTo: number)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        Navigator.pop(context);
        showtoast(context, "Mobile Number not Registered", Colors.red);
        return;
      } else {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(value.docs[0].id)
            .get()
            .then((value) {
          if (value.data()!['password'] != password) {
            Navigator.pop(context);
            showtoast(context, "Incorrect Password", Colors.red);
            return;
          } else {
            setlogin(true, number);
            Navigator.pop(context);
            showtoast(context, "Successfully Logged In", Colors.green);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
            return;
          }
        });
      }
    });
    setSending(false);
    notifyListeners();
  }
}
