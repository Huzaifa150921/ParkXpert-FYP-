import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parkxpert/res/routes/route_name.dart';

class MapControllerX extends GetxController {
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  RxBool isLoading = true.obs;
  final MapController mapController = MapController();

  @override
  void onInit() {
    super.onInit();
    determinePosition();
  }

  Future<void> determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          isLoading.value = false;
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      currentPosition.value = LatLng(position.latitude, position.longitude);

      // Ensure the map moves only when it's in the widget tree
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (currentPosition.value != null) {
          mapController.move(currentPosition.value!, 13.0);
        }
      });

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapControllerX controller = Get.put(MapControllerX());
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 73, 73),
      body: Stack(
        children: [
          // MAP SECTION
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: controller.currentPosition.value ??
                    LatLng(37.7749, -122.4194),
                initialZoom: 13.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (controller.currentPosition.value != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.currentPosition.value!,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            );
          }),

          // FIND PARKING CARD (ALWAYS VISIBLE)
          Positioned(
            top: screenheight * 0.65,
            right: 0,
            left: screenwidth * 0.007,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
              child: Card(
                color: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return Text(
                          controller.currentPosition.value != null
                              ? "\nLat: ${controller.currentPosition.value!.latitude.toStringAsFixed(5)}, "
                                  "Lng: ${controller.currentPosition.value!.longitude.toStringAsFixed(5)}"
                              : "Getting Location...",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      SizedBox(height: screenheight * 0.02),
                      SizedBox(
                        width: screenwidth - 40,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenheight * 0.018),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenwidth * 0.03),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Enter Location',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenheight * 0.02),
                      SizedBox(
                        width: screenwidth * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(RouteName.displayParking);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 144, 221, 71),
                            foregroundColor:
                                const Color.fromARGB(255, 8, 204, 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Find a Parking',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
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
