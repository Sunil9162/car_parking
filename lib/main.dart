import 'package:car_parking/providers/auth_providers.dart';
import 'package:car_parking/providers/book_slot_provider.dart';
import 'package:car_parking/providers/parking_provider.dart';
import 'package:car_parking/views/Home/home_page.dart';
import 'package:car_parking/views/Parking/parking_details_page.dart';
import 'package:car_parking/views/Parking/parking_for_page.dart';
import 'package:car_parking/views/auth/login_page.dart';
import 'package:car_parking/views/auth/otp_page.dart';
import 'package:car_parking/views/auth/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/Home/mybooking_page.dart';
import 'views/auth/add_password_page.dart';

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

void main() async {
  FlutterNativeSplash.removeAfter(initialization);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  isLoggedIn().then((value) {
    runApp(MyApp(isLoggedIn: value));
  });
}

void initialization(BuildContext context) async {
  precacheImage(const AssetImage("assets/images/logo.png"), context);
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ParkingProvider()),
        ChangeNotifierProvider(create: (_) => BookSlotProvider()),
      ],
      child: MaterialApp(
        title: 'Car Parking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        home: widget.isLoggedIn ? const HomePage() : const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
          '/otp': (context) => const OtpPage(),
          '/addpassword': (context) => const AddPassWordPage(),
          '/forvehicle': (context) => const ParkingForVehiclePage(),
          '/mybookings': (context) => const MyBookingPage(),
        },
      ),
    );
  }
}
