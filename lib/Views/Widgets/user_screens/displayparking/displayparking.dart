import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkxpert/Views/Widgets/user_screens/displayparking/parking_detail_screen.dart';

class DisplayParking extends StatelessWidget {
  DisplayParking({super.key});

  final List<Map<String, dynamic>> parkingList = [
    {
      "name": "Downtown Parking Lot",
      "location": "456 Elm Street, Downtown",
      "price": "₨400 per hour",
      "image": "assets/images/parking3.jpg",
      "owner": "Michael Smith",
      "ownerImage": "assets/images/default_profile_pic.jfif",
      "slots": [
        {"slotNumber": 1, "status": "available"},
        {"slotNumber": 2, "status": "occupied"},
        {"slotNumber": 3, "status": "reserved"},
        {"slotNumber": 4, "status": "available"},
        {"slotNumber": 5, "status": "occupied"},
        {"slotNumber": 6, "status": "available"},
        {"slotNumber": 7, "status": "reserved"},
        {"slotNumber": 8, "status": "occupied"},
        {"slotNumber": 9, "status": "available"},
        {"slotNumber": 10, "status": "reserved"}
      ]
    },
    {
      "name": "Greenway Parking",
      "price": "₨250 per hour",
      "location": "456 Oak Avenue, Downtown",
      "image": "assets/images/parking4.jpg",
      "owner": "Sophia Brown",
      "ownerImage": "assets/images/default_profile_pic.jfif",
      "phone": "+123 456 7890",
      "slots": [
        {"slotNumber": 1, "status": "occupied"},
        {"slotNumber": 2, "status": "available"},
        {"slotNumber": 3, "status": "reserved"},
        {"slotNumber": 4, "status": "available"},
        {"slotNumber": 5, "status": "occupied"},
        {"slotNumber": 6, "status": "reserved"},
        {"slotNumber": 7, "status": "available"},
        {"slotNumber": 8, "status": "reserved"},
        {"slotNumber": 9, "status": "occupied"},
        {"slotNumber": 10, "status": "available"},
        {"slotNumber": 11, "status": "reserved"},
        {"slotNumber": 12, "status": "available"},
        {"slotNumber": 13, "status": "occupied"},
        {"slotNumber": 14, "status": "reserved"},
        {"slotNumber": 15, "status": "available"}
      ]
    },
    {
      "name": "Town Parking",
      "price": "₨4000 per hour",
      "location": "456 Jalil Town, Downtown",
      "image": "assets/images/parking4.jpg",
      "owner": "Huzaifa",
      "ownerImage": "assets/images/default_profile_pic.jfif",
      "phone": "+92 3123679363",
      "slots": [
        {"slotNumber": 1, "status": "occupied"},
        {"slotNumber": 2, "status": "reserved"},
        {"slotNumber": 3, "status": "reserved"},
        {"slotNumber": 4, "status": "occupied"},
        {"slotNumber": 5, "status": "occupied"},
        {"slotNumber": 6, "status": "reserved"},
        {"slotNumber": 7, "status": "occupied"},
        {"slotNumber": 8, "status": "reserved"},
        {"slotNumber": 9, "status": "occupied"},
        {"slotNumber": 10, "status": "reserved"},
        {"slotNumber": 11, "status": "reserved"},
        {"slotNumber": 12, "status": "reserved"},
        {"slotNumber": 13, "status": "occupied"},
        {"slotNumber": 14, "status": "reserved"},
        {"slotNumber": 15, "status": "occupied"}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            "Parking Details",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        itemCount: parkingList.length,
        itemBuilder: (context, index) {
          var parking = parkingList[index];
          int availableSlots = parking["slots"]
              .where((slot) => slot["status"] == "available")
              .length;

          return GestureDetector(
            onTap: () {
              Get.to(
                () => ParkingDetailScreen(parking: parking),
                transition: Transition.fadeIn,
                duration: Duration(seconds: 1),
              );
            },
            child: Hero(
              tag: "parkingCard${parking["name"]}",
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.blueAccent.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Card(
                      // ignore: deprecated_member_use
                      color: Colors.grey[900]?.withOpacity(0.85),
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              parking["name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.currency_rupee,
                                    color: Colors.greenAccent, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  parking["price"],
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.local_parking,
                                    color: Colors.blueAccent.shade200,
                                    size: 22),
                                const SizedBox(width: 6),
                                Text(
                                  "Available Slots: $availableSlots",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 17),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.redAccent, size: 22),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    parking["location"],
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 17),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
