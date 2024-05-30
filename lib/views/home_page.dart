import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'reservation_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();
  final TextEditingController _roomTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Reservations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('reservations').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Reservations Found'));
                } else {
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return ReservationTile(
                        docId: document.id,
                        name: document['name'],
                        checkInDate: document['checkInDate'],
                        checkOutDate: document['checkOutDate'],
                        roomType: document['roomType'],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Guest Name'),
                ),
                TextField(
                  controller: _checkInController,
                  decoration: const InputDecoration(labelText: 'Check-In Date'),
                ),
                TextField(
                  controller: _checkOutController,
                  decoration: const InputDecoration(labelText: 'Check-Out Date'),
                ),
                TextField(
                  controller: _roomTypeController,
                  decoration: const InputDecoration(labelText: 'Room Type'),
                ),
                ElevatedButton(
                  onPressed: addReservation,
                  child: const Text('Add Reservation'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addReservation() {
    FirebaseFirestore.instance.collection('reservations').add({
      'name': _nameController.text,
      'checkInDate': _checkInController.text,
      'checkOutDate': _checkOutController.text,
      'roomType': _roomTypeController.text,
    });
    _nameController.clear();
    _checkInController.clear();
    _checkOutController.clear();
    _roomTypeController.clear();
  }
}
