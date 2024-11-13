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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.07),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Our location",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 33,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  SizedBox(
                    height: screenSize.height * 0.4,
                    width: screenSize.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                        },
                        myLocationEnabled: true,
                        markers: _markers,
                        onTap: (argument) async {},
                        mapType: MapType.normal,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(40.732253, -74.003659),
                          zoom: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  const Text(
                    "23 Commerce St (btwn Bedford St & 7th Ave S), New York, NY 10014",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  const Text(
                    "Located in the West Village, Sushi Shukan offers an exquisite omakase experience under the guidance of Chef Daisuke Nakazawa, a protégé of Jiro Ono.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
