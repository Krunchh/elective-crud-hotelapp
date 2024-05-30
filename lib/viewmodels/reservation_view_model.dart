import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationViewModel {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> get reservationsStream => firestore.collection('reservations').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList(),
      );

  Future<void> addReservation(Map<String, dynamic> reservationData) {
    return firestore.collection('reservations').add(reservationData);
  }

  Future<void> updateReservation(String docId, Map<String, dynamic> newData) {
    return firestore.collection('reservations').doc(docId).update(newData);
  }

  Future<void> deleteReservation(String docId) {
    return firestore.collection('reservations').doc(docId).delete();
  }
}
