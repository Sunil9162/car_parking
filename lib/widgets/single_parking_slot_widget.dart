import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_parking/models/parking_models.dart';
import 'package:car_parking/views/Parking/parking_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkingSlotWidget extends StatelessWidget {
  final ParkingSlotModels models;
  const ParkingSlotWidget({Key? key, required this.models}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ParkingDetailsPage(
              models: models,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Hero(
                tag: models.id,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://media.istockphoto.com/vectors/car-parking-icon-vector-id1083622428?k=20&m=1083622428&s=612x612&w=0&h=pgKz3ptT-VgQiXZ7cVolMLeXKy9Ma5YKrfeE7SmDLQ8=",
                  width: MediaQuery.of(context).size.width * 0.3,
                  placeholder: (context, url) {
                    return const CupertinoActivityIndicator();
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      models.createdbyname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "By : " + models.cretedby,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      models.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text("₹" + models.perhourrate.toString() + "/hr"),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
