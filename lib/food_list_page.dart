import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  FoodListPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yemek Listesi'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Yemek Listesi'),
            ),
          ],
        ));
  }
}
