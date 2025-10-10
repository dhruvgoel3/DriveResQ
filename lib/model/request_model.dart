import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';


class RequestSOS {
  String id;
  String userId;
  String? mechanicId;
  GeoPoint locations;
  String vehicleInfo;
  String IssueDescription;
  String Status;
  String Area;
  Timestamp timestamp;

  RequestSOS({
    required this.id,
    required this.userId,
    this.mechanicId,
    required this.locations,
    required this.vehicleInfo,
    required this.IssueDescription,
    required this.Status,
    required this.Area,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "mechanicId": mechanicId,
      "Location": locations,
      "vehicleInfo": vehicleInfo,
      "IssueDescription": IssueDescription,
      "Status": Status,
      "Area": Area,
      "TimeStamp": timestamp,
    };
  }

  factory RequestSOS.fromMap(Map<String, dynamic> data, String docId) {
    return RequestSOS(
      id: docId,
      userId: data["userId"],
      locations: data["locations"],
      vehicleInfo: data["vehichleInfo"],
      IssueDescription: data["IssueDescription"],
      Status: data["data"],
      Area: data["Status"],
      timestamp: data["TimeStamp"],
    );
  }
}
