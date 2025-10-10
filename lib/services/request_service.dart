import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driveresq/model/request_model.dart';

class Request {
  final _firestore = FirebaseFirestore.instance;
  final _request = FirebaseFirestore.instance.collection("SOSRequest");

  Future<void> createSOSRequest(RequestSOS Request) async {
    await _request.doc(Request.id).set(Request.toMap());
  }

  Future<void> MechanicStatus(String RequestId, String mechanicId) async {
    await _request.doc(RequestId).update({
      "mechanicId": mechanicId,
      "Status": 'accepted',
    });
  }

  Stream<List<RequestSOS>> getRequestforUser(String userId) {
    return _request
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RequestSOS.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<RequestSOS>> getRequestforMechanic(String mechanicID) {
    return _request
        .where("mechanicId", isEqualTo: mechanicID)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RequestSOS.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }
}
