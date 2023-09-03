import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification/screens/chat_screen.dart';
import 'package:firebase_notification/screens/profile_screen.dart';
import 'package:firebase_notification/widget/container_widget.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              backgroundImage: NetworkImage(user!.photoURL.toString()),
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Notifications",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, int index) {
                        String userId = snapshot.data!.docs[index]["id"];
                        String imageUrl =
                            snapshot.data!.docs[index]["photoUrl"];
                        String name = snapshot.data!.docs[index]["name"];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => ChatScreen(
                                            name: name,
                                            recievUserId: userId,
                                            image_url: imageUrl,
                                          ))));
                            },
                            child: ContainerWidget(
                                path: imageUrl, name: name, time: "08:39 AM"),
                          ),
                        );
                      }));
                }
              })),
    );
  }
}
