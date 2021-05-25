import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("recipes").snapshots(),
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
//
//
          final QuerySnapshot querySnapshot = snapshot.data;
          final map = querySnapshot.docs[1].data();
          final _minutes = map['minutes'];
          final _name = map['name'];
          final _image = map['image'];
//
//
          return Column(
            children: [
              Container(
                child: Image.network(_image),
                margin: const EdgeInsets.only(
                    top: 50, left: 50, right: 50, bottom: 15),
                width: 380,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      '$_name',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 45.0),
                    child: Text('Cooking time : $_minutes min'),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 60,
                    child: IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.red,
                      iconSize: 40,
                      highlightColor: Colors.red,
                      onPressed: () {
                        print("Butona 1 Kez Tıklandı");
                      },
                    ),
                  )),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: IconButton(
                          icon: Icon(Icons.access_alarm),
                          color: Colors.red,
                          iconSize: 40,
                          highlightColor: Colors.red,
                          onPressed: () {
                            print("Butona 1 Kez Tıklandı");
                          }),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
