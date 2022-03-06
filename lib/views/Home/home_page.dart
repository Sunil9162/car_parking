import 'package:car_parking/providers/parking_provider.dart';
import 'package:car_parking/widgets/custom_app_bar.dart';
import 'package:car_parking/widgets/custom_icon_button.dart';
import 'package:car_parking/widgets/single_parking_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    final _controller = Provider.of<ParkingProvider>(context, listen: false);
    _controller.getParkings(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const CustomAppBar(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/mybookings');
        },
        label: const Text('My Bookings'),
        icon: const Icon(Icons.car_rental),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              const Color(0xFFB8A0F0),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.282,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Find your Parking Space",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height - 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(top: 10),
                child: Consumer<ParkingProvider>(
                  builder: (BuildContext context, _controller, Widget? child) =>
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SmartRefresher(
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onRefresh: () {
                        _controller.getParkings(context).then((value) {
                          _refreshController.refreshCompleted();
                        });
                      },
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomIconButton(
                                  image: "assets/images/car.png",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forvehicle');
                                  },
                                  title: "Car",
                                ),
                                CustomIconButton(
                                  image: "assets/images/bus.png",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forvehicle');
                                  },
                                  title: "Bus",
                                ),
                                CustomIconButton(
                                  image: "assets/images/bike.png",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forvehicle');
                                  },
                                  title: "Bike",
                                ),
                                CustomIconButton(
                                  image: "assets/images/van.png",
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forvehicle');
                                  },
                                  title: "Van",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              " Nearby Parkings",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            _controller.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : _controller.parkings.isEmpty
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: const Center(
                                          child: Text(
                                            "No Parkings available",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(top: 10),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _controller.parkings.length,
                                        itemBuilder: (context, index) {
                                          return ParkingSlotWidget(
                                            models: _controller.parkings[index],
                                          );
                                        },
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
