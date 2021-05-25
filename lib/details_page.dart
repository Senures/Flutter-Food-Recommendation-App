import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String image;

  DetailsPage(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$name'),
        ),
        body: Column(
          children: [
            Center(
              child: Image.network(image),
            ),
            Center(
              child: Text('Name: $name'),
            ),
          ],
        ));
  }
}
