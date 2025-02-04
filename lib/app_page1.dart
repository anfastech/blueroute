// First, add these dependencies to pubspec.yaml:
// google_maps_flutter: ^2.5.0
// geolocator: ^10.1.0
// permission_handler: ^11.0.1

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Position? currentPosition;
  
  // Initial camera position (will be updated with user's location)
  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Request location permission
    final permission = await Permission.location.request();
    
    if (permission.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
        );
        
        setState(() {
          currentPosition = position;
        });

        // Move camera to current location
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude)
            )
          );
        }
      } catch (e) {
        print("Error getting location: $e");
      }
    } else {
      print("Location permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Sharing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          if (currentPosition != null) {
            controller.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(currentPosition!.latitude, currentPosition!.longitude)
              )
            );
          }
        },
      ),
    );
  }
}