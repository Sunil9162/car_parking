import 'package:car_parking/providers/parking_provider.dart';
import 'package:car_parking/widgets/single_parking_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ParkingForVehiclePage extends StatefulWidget {
  const ParkingForVehiclePage({Key? key}) : super(key: key);

  @override
  _ParkingForVehiclePageState createState() => _ParkingForVehiclePageState();
}

class _ParkingForVehiclePageState extends State<ParkingForVehiclePage> {
  final _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommended Parkings',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              const Color(0xFFB8A0F0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<ParkingProvider>(
          builder: (BuildContext context, value, Widget? child) =>
              SmartRefresher(
            controller: _controller,
            enablePullDown: true,
            onRefresh: () {
              value.getParkings(context).then((value) {
                _controller.refreshCompleted();
              });
            },
            child: value.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: value.parkings.length,
                    itemBuilder: (context, index) {
                      return ParkingSlotWidget(
                        models: value.parkings[index],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
