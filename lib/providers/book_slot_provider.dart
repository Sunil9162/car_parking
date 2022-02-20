import 'package:car_parking/models/mybooking_model.dart';
import 'package:car_parking/models/slot_booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookSlotProvider extends ChangeNotifier {
  bool isLoading = false;
  bool get getIsLoading => isLoading;

  final _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> bookSlot({
    required int slotId,
    required String createdByName,
    required String startTime,
    required String endTime,
    required String startDate,
    required String endDate,
    required BuildContext context,
    required String name,
    required String address,
  }) async {
    isLoading = true;
    notifyListeners();
    var bookingId = DateTime.now().microsecondsSinceEpoch;
    var isSuccess = false;
    final _prefs = await SharedPreferences.getInstance();
    final number = _prefs.getString('number');
    _firestore
        .collection("Users")
        .where("number", isEqualTo: number)
        .get()
        .then((nvalue) {
      _firestore
          .collection("Users")
          .doc(nvalue.docs.first.id)
          .get()
          .then((mvalue) async {
        if (mvalue.exists) {
          await _firestore.collection("Bookings").add(
                MyBookingModel(
                  createdby: mvalue.data()!['number'],
                  createdbyname: createdByName,
                  slot: slotId,
                  starttime: startDate + startTime,
                  endtime: endDate + endTime,
                  isactive: true,
                  ispaid: false,
                  bookingid: bookingId.toString(),
                  name: name,
                  address: address,
                ).toJson(),
              );
          await _firestore
              .collection("Users")
              .doc(nvalue.docs.first.id)
              .collection("bookings")
              .add(
                MyBookingModel(
                  createdby: mvalue.data()!['number'],
                  createdbyname: createdByName,
                  slot: slotId,
                  starttime: startDate + " " + startTime,
                  endtime: endDate + " " + endTime,
                  isactive: true,
                  ispaid: false,
                  bookingid: bookingId.toString(),
                  address: address,
                  name: name,
                ).toJson(),
              )
              .then((pvalue) async {
            isSuccess = true;
            isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong"),
            ),
          );
          isLoading = false;
          notifyListeners();
        }
      });
    });
    Navigator.pop(context);
    notifyListeners();
    return Future.value({
      "bookingId": bookingId,
      'isSuccess': isSuccess,
    });
  }
}
