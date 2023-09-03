import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
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
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.5,
                height: MediaQuery.sizeOf(context).height / 5,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoURL.toString()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Nom : ${user!.displayName.toString()}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email : ${user!.email.toString()}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: user!.phoneNumber == null
                    ? const Text(
                        "Numero : Pas de numero enregistrer ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    : Text(
                        "Numero : ${user!.phoneNumber.toString()}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      )),
          ],
        ),
      ),
    );
  }
}
