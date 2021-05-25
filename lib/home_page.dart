import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/food_list_page.dart';
import 'package:flutter_application_1/recommend_page.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var sayfaListe = [
    FoodListPage(),
    RecommendPage(),
  ]; //sayfa listesi,bu indekslere body kısmında erişerek body içinde gösteririz
  int secilenIndeks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yemek öneri uygulaması"),
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
      body: sayfaListe[secilenIndeks],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                "",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover),
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text(
                "Yemek listesi",
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
              leading: Icon(
                Icons.check,
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  secilenIndeks = 0; //sayfa 1 i açar
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text(
                  "Öneri Sistemi",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                leading: Icon(
                  Icons.star_border,
                  color: Colors.red,
                ),
                onTap: () {
                  setState(() {
                    //arayüzü güncellemek için setstate,set çalısınca build metodu tekrar çalışır
                    secilenIndeks = 1;
                  });
                  Navigator.pop(
                      context); //sayfa 2 yi seçtikten snra drawerın kenara çekilmesini sağlıyor
                }),
          ],
        ),
      ),
    );
  }
}
