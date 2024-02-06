import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab1/components/button_component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              centerTitle: true,
              title: const Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'EduSABeginner',
                  fontWeight: FontWeight.w900,
                  color: Colors.indigo,
                  fontSize: 25,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      snapshot.data?['name'] ?? "Not Found",
                      style: const TextStyle(
                        fontFamily: 'EduSABeginner',
                        fontWeight: FontWeight.w900,
                        color: Colors.indigo,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      snapshot.data?['email'] ?? "Not Found",
                      style: const TextStyle(
                        fontFamily: 'EduSABeginner',
                        fontWeight: FontWeight.w900,
                        color: Colors.indigo,
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      snapshot.data?['phone'] ?? "Not Found",
                      style: const TextStyle(
                        fontFamily: 'EduSABeginner',
                        fontWeight: FontWeight.w900,
                        color: Colors.indigo,
                        fontSize: 35,
                      ),
                    ),
                    MaterialButtonComponent(
                      text: 'Logout',
                      onPressed: () async {
                        {
                          await FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushReplacementNamed(
                                  context, 'loginScreen'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
