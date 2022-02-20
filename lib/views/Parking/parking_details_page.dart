import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_parking/constants/show_spinner.dart';
import 'package:car_parking/models/parking_models.dart';
import 'package:car_parking/providers/book_slot_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ParkingDetailsPage extends StatefulWidget {
  final ParkingSlotModels models;
  const ParkingDetailsPage({Key? key, required this.models}) : super(key: key);

  @override
  _ParkingDetailsPageState createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  final _nameController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _departureDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text('Parking Details'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      backgroundColor: Colors.blue.shade800,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 8,
                  left: 8,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Hero(
                            tag: widget.models.id,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://media.istockphoto.com/vectors/car-parking-icon-vector-id1083622428?k=20&m=1083622428&s=612x612&w=0&h=pgKz3ptT-VgQiXZ7cVolMLeXKy9Ma5YKrfeE7SmDLQ8=",
                              width: MediaQuery.of(context).size.width * 0.3,
                              placeholder: (context, url) {
                                return const CupertinoActivityIndicator();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.models.createdbyname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "By : " + widget.models.cretedby,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Add- " + widget.models.address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Driver Name",
                        labelStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _arrivalDateController,
                            decoration: InputDecoration(
                              labelText: "Arrival Date",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime(2022),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _arrivalDateController.text =
                                        DateFormat('dd-MM-y').format(value);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _arrivalTimeController,
                            decoration: InputDecoration(
                              labelText: "Arrival Time",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _arrivalTimeController.text =
                                        value.format(context);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _departureDateController,
                            decoration: InputDecoration(
                              labelText: "Departure Date",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime(2022),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _departureDateController.text =
                                        DateFormat('dd-MM-y').format(value);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _departureTimeController,
                            decoration: InputDecoration(
                              labelText: "Departure Time",
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  setState(() {
                                    _departureTimeController.text =
                                        value.format(context);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.8,
            height: 45,
            onPressed: () async {
              if (_nameController.text.isEmpty &&
                  _arrivalDateController.text.isEmpty &&
                  _arrivalTimeController.text.isEmpty &&
                  _departureDateController.text.isEmpty &&
                  _departureTimeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all the fields")),
                );
              } else {
                try {
                  showSpinner(context, "Booking Slot");
                  final _controller =
                      Provider.of<BookSlotProvider>(context, listen: false);
                  await _controller
                      .bookSlot(
                    slotId: widget.models.id,
                    createdByName: _nameController.text,
                    startTime: _arrivalTimeController.text,
                    endTime: _departureTimeController.text,
                    startDate: _arrivalDateController.text,
                    endDate: _departureDateController.text,
                    context: context,
                    name: widget.models.createdbyname,
                    address: widget.models.address,
                  )
                      .then((value) {
                    if (value['bookingId'] != "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Slot Booked Successfully",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(context, '/mybookings');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Slot Booking Failed",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Something went wrong",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text("Book Slot Now"),
            color: Colors.amber,
            shape: const StadiumBorder(),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
