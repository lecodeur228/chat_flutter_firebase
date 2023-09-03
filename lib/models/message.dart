import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sender_id;
  final String sender_email;
  final String receiver_id;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.sender_id,
    required this.sender_email,
    required this.receiver_id,
    required this.message,
    required this.timestamp,
  });

  //convertir en map les données

  Map<String, dynamic> toMap() {
    return {
      "senderId": sender_id,
      "senderEmail": sender_email,
      "receiverId": receiver_id,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
