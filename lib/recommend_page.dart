import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

class RecommendPage extends StatelessWidget {
  RecommendPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Öneri Sistemi'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("recipes").snapshots(),
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
              final _minutes = map['minutes'];
              final _name = map['name'];
              final _image = map['image'];
              return ListTile(
                leading: Image.network(_image),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(_name, _image)),
                  ),
                },
                subtitle: Text('Cooking time $_minutes minutes'),
                trailing: Icon(Icons.more_vert),
                title: Text(_name),
              );
            },
          );
        },
      ),
    );
  }
}
