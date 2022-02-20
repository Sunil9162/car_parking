import 'package:car_parking/models/mybooking_model.dart';
import 'package:car_parking/widgets/single_my_booking_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  String docId = "";
  @override
  void initState() {
    super.initState();
    getDocId();
  }

  bool isLoading = true;

  final List<MyBookingModel> _bookings = [];

  Future<void> getDocId() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var number = prefs.getString('number');
    FirebaseFirestore.instance
        .collection("Users")
        .where("number", isEqualTo: number)
        .get()
        .then((value) {
      setState(() {
        docId = value.docs[0].id;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.blue.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade800,
      body: docId == ""
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(docId)
                  .collection("bookings")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  _bookings.clear();
                  for (var element in snapshot.data!.docs) {
                    _bookings.add(MyBookingModel.fromJson(element.data()));
                  }
                  if (_bookings.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Bookings Found",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      return SingleMyBookingItem(
                        model: _bookings[index],
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
