import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_parking/models/mybooking_model.dart';
import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SingleMyBookingItem extends StatefulWidget {
  final MyBookingModel model;
  const SingleMyBookingItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _SingleMyBookingItemState createState() => _SingleMyBookingItemState();
}

class _SingleMyBookingItemState extends State<SingleMyBookingItem> {
  late MyBookingModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: QrImage(
                        data: model.bookingid,
                        version: QrVersions.auto,
                        size: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.address,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model.bookingid,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "StartDate: " + model.starttime,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "EndDate: " + model.endtime,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://media.istockphoto.com/vectors/car-parking-icon-vector-id1083622428?k=20&m=1083622428&s=612x612&w=0&h=pgKz3ptT-VgQiXZ7cVolMLeXKy9Ma5YKrfeE7SmDLQ8="),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Booking ID: ${model.bookingid}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Date: ${model.starttime}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paid: ${model.ispaid ? "Yes" : "No"}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Status: ${model.isactive ? "Active" : "Inactive"}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
