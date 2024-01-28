// main.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:safebee/2nd_page.dart';
import 'package:safebee/Settings/addMapLocation.dart';
import 'package:safebee/Settings/bookletPage.dart';
import 'package:safebee/Settings/mapsPage.dart';
import 'package:safebee/Settings/settingsPage.dart';
import 'package:safebee/screens/contacts_page.dart';
import 'package:safebee/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart'; //imported to support calls and messages

//changed the main startup to be able to call the setupLocator to support calls and messages
//was having errors before, for not calling this in main.
void main() {
  setupLocator(); // Call setupLocator before runApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe bee',
      routes: {
        '/mapsPage': (context) => const MapsPage(),
        '/bookletPage': (context) => BookletPage(),
        '/addMapLocation': (context) => AddMapLocation(),
        '/contacts_Page': (context) => ContactsPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  Location location = Location();
  LatLng _currentPosition = const LatLng(40.785091, -83.968285);
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _initializeMarkers() async {
    await _addCurrentLocationMarker();
    await _addFamilyMarkers();
  }

  void _checkLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("Location service not enabled");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("Location permission not granted");
        return;
      }
    }
    _initializeMarkers();
  }

  Future<void> _addCurrentLocationMarker() async {
    final locData = await location.getLocation();
    if (locData != null) {
      LatLng currentLocation =
          LatLng(locData.latitude ?? 9999, locData.longitude ?? 999);
      setState(() {
        _currentPosition = currentLocation;
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: currentLocation,
            infoWindow: const InfoWindow(
              title: 'Current Location',
              snippet: 'This is your current location',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );
      });
    } else {
      print("Failed to get current location");
    }
  }

  Future<void> _addFamilyMarkers() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('mapsMenuItems') ?? '[]';
    List<MapsObject> savedLocations = MapsObject.decode(jsonString);

    for (var location in savedLocations) {
      try {
        List<String> latLng = location.Location.split(',');
        double latitude = double.parse(latLng[0]);
        double longitude = double.parse(latLng[1]);
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(location.id),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(
                title: location.id,
                snippet:
                    '${latitude.toStringAsFixed(3)}, ${longitude.toStringAsFixed(3)}',
              ),
            ),
          );
        });
      } catch (e) {
        print('Error parsing location data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe bee'),
        // This icon is typically included by default when using a Drawer
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Main Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            // Add more list tiles here
          ],
        ),
      ),
      body: Stack(
        children: [
          // Your GoogleMap widget
          _currentPosition.latitude == 111.0 &&
                  _currentPosition.longitude == 111.0
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 15.0,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

          // Centered "Danger" button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                  onPrimary: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
                child: const Text(
                  'DANGER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapsObject {
  String id;
  String Location;

  MapsObject({required this.id, required this.Location});

  factory MapsObject.fromJson(Map<String, dynamic> json) {
    return MapsObject(
      id: json['id'] as String,
      Location: json['Location'] as String,
    );
  }

  static List<MapsObject> decode(String jsonString) =>
      (json.decode(jsonString) as List)
          .map((item) => MapsObject.fromJson(item as Map<String, dynamic>))
          .toList();

  // You might also want to implement a method to convert MapsObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Location': Location,
    };
  }
}
