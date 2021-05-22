import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signin_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Query query = FirebaseFirestore.instance.collection("recipe");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Başarıyla çıkış yapıldı"),
                ));

                Navigator.pushReplacement(
                  //bunu kullanma amacımız çıkış tuşuna bastığımız halde geri tuşuna basarsak giriş yapılmış halde duracağından pushReclacement kullanılır
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("recipe").snapshots(),
        //query.snapshots(), //future olsa stream yerine future .snapshots() yerine .get()
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(Icons.error),
            );
          }

          final QuerySnapshot querySnapshot = snapshot.data;
          return ListView.builder(
            itemCount: querySnapshot.size,
            itemBuilder: (context, index) {
              final map = querySnapshot.docs[index].data();
              return ListTile(
                title: Text(map['name']),
              );
            },
          );
        },
      ),
    );
  }
}
