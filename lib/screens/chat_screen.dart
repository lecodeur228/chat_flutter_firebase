import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification/services/chatservices/chat_services.dart';
import 'package:firebase_notification/widget/chat_buble.dart';
import 'package:firebase_notification/widget/my_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String recievUserId;
  final String image_url;
  const ChatScreen(
      {super.key,
      required this.name,
      required this.recievUserId,
      required this.image_url});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void SendMessage() async {
    if (messageController.text.isNotEmpty) {
      await ChatService()
          .sendMessages(widget.recievUserId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        elevation: 4,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          widget.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // afficher la liste des messages
          Expanded(child: messageList()),
          //zone de saisie de messages

          messageInput(messageController),
        ],
      ),
    );
  }

  Widget messageList() {
    return StreamBuilder(
        stream: ChatService()
            .getMessages(widget.recievUserId, firebaseAuth.currentUser!.uid),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => messageItem(document))
                .toList(),
          );
        }));
  }

  Widget messageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp getTime = data["timestamp"];
    DateTime time = getTime.toDate();
    String dateTime = DateFormat('dd/MM HH:mm').format(time);
    //aligner le message a gauche si c'est recu et a droite si c'est envoyé
    var alignement = (data["senderId"] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignement,
      child: Column(
        crossAxisAlignment: (data["senderId"] == firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data["senderId"] == firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment:
                  (data["senderId"] == firebaseAuth.currentUser!.uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              mainAxisAlignment:
                  (data["senderId"] == firebaseAuth.currentUser!.uid)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                data["senderId"] != firebaseAuth.currentUser!.uid
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.image_url.toString()),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChatBuble(
                      isSend:
                          (data["senderId"] == firebaseAuth.currentUser!.uid),
                      text: data["message"]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(dateTime),
          ),
        ],
      ),
    );
  }

  Widget messageInput(TextEditingController messageController) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
              child: MyInput(
                  controller: messageController,
                  text: "Entrez le message...",
                  isObscure: false)),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.amberAccent, shape: BoxShape.circle),
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(5),
              child: IconButton(
                  onPressed: SendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
