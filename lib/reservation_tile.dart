import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationTile extends StatefulWidget {
  final String docId;
  final String name;
  final String checkInDate;
  final String checkOutDate;
  final String roomType;

  const ReservationTile({
    Key? key,
    required this.docId,
    required this.name,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomType,
  }) : super(key: key);

  @override
  _ReservationTileState createState() => _ReservationTileState();
}

class _ReservationTileState extends State<ReservationTile> {
  late TextEditingController _nameController;
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;
  late TextEditingController _roomTypeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _checkInController = TextEditingController(text: widget.checkInDate);
    _checkOutController = TextEditingController(text: widget.checkOutDate);
    _roomTypeController = TextEditingController(text: widget.roomType);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _roomTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name),
        subtitle: Text('Check-in: ${widget.checkInDate} - Check-out: ${widget.checkOutDate}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editReservation(context),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReservation(widget.docId),
            ),
          ],
        ),
      ),
    );
  }

  void _editReservation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Reservation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('reservations').doc(widget.docId).update({
                  'name': _nameController.text,
                  'checkInDate': _checkInController.text,
                  'checkOutDate': _checkOutController.text,
                  'roomType': _roomTypeController.text,
                }).then((_) {
                  Navigator.of(context).pop();
                  setState(() {
                    // Update the parent widget state if necessary
                  });
                });
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteReservation(String docId) {
    FirebaseFirestore.instance.collection('reservations').doc(docId).delete();
  }
}
