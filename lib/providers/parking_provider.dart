import 'dart:convert';
import 'dart:developer';

import 'package:car_parking/models/parking_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingProvider extends ChangeNotifier {
  List<ParkingSlotModels> parkings = [];
  bool isLoading = false;

  Future<void> getParkings(BuildContext context) async {
    isLoading = true;
    final response = await http
        .get(Uri.parse('https://ddsio.com/car-parking/api/slots/?format=json'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      parkings = (jsonResponse as List)
          .map(
            (parking) => ParkingSlotModels.fromJson(parking),
          )
          .toList();
    } else {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load data'),
        ),
      );
      throw Exception('Failed to load parking slots');
    }

    isLoading = false;
    notifyListeners();
  }
}
