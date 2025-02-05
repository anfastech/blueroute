import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  bool _isLoading = true;
  bool _isTracking = false;
  String _errorMessage = '';
  StreamSubscription<Position>? _locationStream;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    try {
      // Check and request location permissions
      bool hasPermission = await _checkLocationPermissions();
      if (!hasPermission) {
        setState(() {
          _errorMessage = "Location permissions are denied.";
          _isLoading = false;
        });
        return;
      }

      // Fetch the current location
      await _getLocation();

      // Start real-time location updates
      _startLocationUpdates();
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to initialize location: $e";
        _isLoading = false;
      });
    }
  }

  Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = "Location services are disabled.";
      });
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage = "Location permissions are permanently denied. Please enable them in the app settings.";
      });
      return false;
    }

    return true;
  }

  Future<void> _getLocation() async {
    try {
      var location = await LocationService().getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(location.latitude, location.longitude);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to get location: $e";
        _isLoading = false;
      });
    }
  }

  void _startLocationUpdates() {
    setState(() {
      _isTracking = true;
    });

    _locationStream = LocationService().getRealTimeLocation().listen(
      (position) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
      },
      onError: (e) {
        setState(() {
          _errorMessage = "Failed to track location: $e";
          _isTracking = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _locationStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Location Sharing"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              : Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        center: _currentPosition,
                        zoom: 15.0,
                        interactiveFlags: InteractiveFlag.all, // Allow map interaction
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentPosition!,
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (_isTracking)
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: FloatingActionButton(
                          onPressed: () {
                            // Stop tracking
                            _locationStream?.cancel();
                            setState(() {
                              _isTracking = false;
                            });
                          },
                          child: Icon(Icons.stop),
                        ),
                      ),
                  ],
                ),
    );
  }
}