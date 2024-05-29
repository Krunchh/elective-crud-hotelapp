import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationTile extends StatelessWidget {
  final String docId;
  final String name;
  final String checkInDate;
  final String checkOutDate;
  final String roomType;

  const ReservationTile({
    super.key,
    required this.docId,
    required this.name,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Check-in: $checkInDate - Check-out: $checkOutDate'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editReservation(context, docId),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReservation(docId),
            ),
          ],
        ),
      ),
    );
  }

  void _editReservation(BuildContext context, String docId) {
    // Implementation to edit a reservation
    // This can open a dialog or another screen with pre-filled form
  }

  void _deleteReservation(String docId) {
    FirebaseFirestore.instance.collection('reservations').doc(docId).delete();
  }
}
