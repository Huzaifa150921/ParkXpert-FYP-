// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParkingDetailScreen extends StatelessWidget {
  final Map<String, dynamic> parking;

  const ParkingDetailScreen({super.key, required this.parking});

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _buildOwnerCard(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildInfoTile(Icons.currency_rupee, Colors.greenAccent,
                          parking["price"] ?? "N/A"),
                      _buildClickableSlotsTile(context),
                      _buildInfoTile(Icons.location_on, Colors.redAccent,
                          parking["location"] ?? "Unknown Location"),
                      _buildInfoTile(Icons.phone, Colors.lightGreen,
                          parking["phone"] ?? "No Phone"),
                      _buildInfoTile(Icons.email, Colors.orangeAccent,
                          parking["email"] ?? "No Email"),
                    ],
                  ),
                ),
                _buildBookingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: AssetImage(parking["ownerImage"] ??
                "assets/images/default_profile_pic.jfif"),
            backgroundColor: Colors.grey[800],
          ),
          const SizedBox(height: 12),
          Text(
            parking["owner"] ?? "Unknown Owner",
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableSlotsTile(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSlotsPopup(context),
      child: _buildInfoTile(Icons.local_parking, Colors.blueAccent,
          "Slots Available: ${(parking["slots"] as List).where((slot) => slot["status"] == "available").length}",
          clickable: true),
    );
  }

  Widget _buildInfoTile(IconData icon, Color color, String text,
      {bool clickable = false}) {
    return Card(
     
      color: Colors.grey[900]!.withOpacity(0.5),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 28),
        title: Text(
          text,
          style: TextStyle(
            color: clickable ? Colors.blueAccent : Colors.white70,
            fontSize: 18,
            fontWeight: clickable ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: clickable
            ? const Icon(Icons.chevron_right, color: Colors.blueAccent)
            : null,
      ),
    );
  }

  Widget _buildBookingButton() {
    int availableSlots = (parking["slots"] as List)
        .where((slot) => slot["status"] == "available")
        .length;

    bool hasAvailableSlots = availableSlots > 0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: hasAvailableSlots
            ? const LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              )
            : const LinearGradient(
                colors: [Colors.grey, Colors.grey],
              ),
      ),
      child: ElevatedButton(
        onPressed: hasAvailableSlots ? () {} : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledForegroundColor: Colors.white.withOpacity(0.6),
          disabledBackgroundColor: Colors.grey,
        ),
        child: Text(
          hasAvailableSlots ? "Book Now" : "No Slots Available",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: hasAvailableSlots ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }

  void _showSlotsPopup(BuildContext context) {
    List<dynamic> slots = parking["slots"] ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 380,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
                  ),
                ),
                child: const Center(
                  child: Text("Available Slots",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.1),
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      String status = slots[index]["status"];
                      Color slotColor = status == "available"
                          ? Colors.green
                          : status == "reserved"
                              ? Colors.yellow
                              : Colors.red;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: slotColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: slotColor.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text("Slot ${slots[index]["slotNumber"]}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
