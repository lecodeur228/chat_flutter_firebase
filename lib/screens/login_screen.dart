import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notification/screens/notification_screen.dart';
import 'package:firebase_notification/services/firebase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              " Connectez vous avec Google",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amberAccent,
                          ),
                        );
                      }));
                  final firebaseUser =
                      (await Firebase().signInWithGoogle()).user;
                  print(firebaseUser);
                  try {
                    if (firebaseUser != null) {
                      final QuerySnapshot result = await FirebaseFirestore
                          .instance
                          .collection("users")
                          .where('id', isEqualTo: firebaseUser.uid)
                          .get();
                      final List<DocumentSnapshot> documents = result.docs;
                      if (documents.isEmpty) {
                        Firebase().saveUser(
                            firebaseUser.uid,
                            firebaseUser.displayName,
                            firebaseUser.email,
                            firebaseUser.photoURL);
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const NotificationScreen())));
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          width: 40,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text('Autentification Google'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
