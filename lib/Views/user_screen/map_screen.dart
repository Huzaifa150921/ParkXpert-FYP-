import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Initial center position for the map
  final LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // San Francisco, CA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: MapController(), // Initialize map controller
        options: MapOptions(
          initialCenter:
              _initialPosition, // Use initialCenter instead of center
          initialZoom: 13.0, // Use initialZoom instead of zoom
        ),
        children: [
          // Load OpenStreetMap tiles
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          // Add a marker at the initial position
          MarkerLayer(
            markers: [
              Marker(
                point: _initialPosition,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
