// main.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:safebee/Settings/addMapLocation.dart';
import 'package:safebee/Settings/bookletPage.dart';
import 'package:safebee/Settings/mapsPage.dart';
import 'package:safebee/Settings/settingsPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe bee',
      routes: {
        '/mapsPage': (context) => MapsPage(),
        '/bookletPage': (context) => BookletPage(),
        '/addMapLocation': (context) => AddMapLocation(),
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

  void _checkLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _getCurrentLocation();
  }

  Future<void> _addFamilyMarkers() async {
    final locData = await location.getLocation();

    LatLng momLocation =
        LatLng(40.7851, -83.9683); // Replace with actual coordinates
    LatLng dadLocation =
        LatLng(40.7855, -83.9688); // Replace with actual coordinates
    LatLng myLocation = LatLng(locData.latitude ?? 111.0,
        locData.longitude ?? 111.0); // Replace with actual coordinates

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('mom_location'),
        position: momLocation,
        infoWindow: const InfoWindow(title: 'Mom', snippet: 'Mom\'s location'),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('dad_location'),
        position: dadLocation,
        infoWindow: const InfoWindow(title: 'Dad', snippet: 'Dad\'s location'),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('my_location'),
        position: myLocation,
        infoWindow: const InfoWindow(title: 'Me', snippet: 'My location'),
      ));
    });
  }

  void _getCurrentLocation() async {
    try {
      await _addFamilyMarkers();
    } catch (e) {
      _isLoading = false;
      // Handle exception when location service fails
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
                'Drawer Header',
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
                  // TODO: Add your danger button functionality here
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
