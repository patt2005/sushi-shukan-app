import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sushi_shukan_app/utilities/colors.dart';
import 'package:sushi_shukan_app/utilities/utils.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _currentPosition;

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("Sushi Shukan"),
      position: LatLng(40.732253, -74.003659),
    ),
  };

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position currentPosition = await Geolocator.getCurrentPosition();
      _currentPosition = CameraPosition(
        zoom: 14,
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _currentPosition == null
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenSize.height * 0.02),
                    const Center(
                      child: Text(
                        "Find Us Here",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    SizedBox(
                      height: screenSize.height * 0.4,
                      width: screenSize.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            GoogleMap(
                              myLocationButtonEnabled: false,
                              onMapCreated:
                                  (GoogleMapController controller) async {
                                _controller.complete(controller);
                              },
                              myLocationEnabled: true,
                              markers: _markers,
                              mapType: MapType.normal,
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(40.732253, -74.003659),
                                zoom: 14,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () async {
                                  if (_currentPosition != null) {
                                    final controller = await _controller.future;
                                    controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          _currentPosition!),
                                    );
                                  }
                                },
                                child: const Icon(
                                  Icons.my_location,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.redAccent,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "23 Commerce St (btwn Bedford St & 7th Ave S), New York, NY 10014",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.building_2_fill,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Located in the West Village, Sushi Shukan offers an exquisite omakase experience under the guidance of Chef Daisuke Nakazawa, a protégé of Jiro Ono.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
