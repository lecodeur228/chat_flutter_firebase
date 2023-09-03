import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notification/models/message.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // recuperer les instances de auth et firestore de firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //envoi de messages

  Future sendMessages(String receiverId, final message) async {
    //recuperer les informations de utilisateur connecter
    final String currentuserId = firebaseAuth.currentUser!.uid;
    final String currentuserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // creer un nouveau message
    Message newMessage = Message(
        sender_id: currentuserId,
        sender_email: currentuserEmail,
        receiver_id: receiverId,
        message: message,
        timestamp: timestamp);
    //construre le message
    List<String> ids = [currentuserId, receiverId];
    //la methode sort() qui va permettre de les triers
    ids.sort();
    String chatroomId = ids.join('_');

    //savegarder le message dans la BD

    await fireStore
        .collection("chat")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //recuperer le message

  Stream<QuerySnapshot> getMessages(String userId, String ortheruserId) {
    List<String> ids = [userId, ortheruserId];
    ids.sort();
    String chatroomId = ids.join('_');

    return fireStore
        .collection("chat")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
