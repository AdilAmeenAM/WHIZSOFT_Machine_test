import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.receiverID,
      required this.senderEmail,
      required this.senderID,
      required this.timestamp});

  // converted to a map

  Map<String, dynamic> toMAp() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'senderEmail': senderEmail,
      ' message': message,
      'timestamp': timestamp
    };
  }
}
