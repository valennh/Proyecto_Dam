import 'package:cert3_dam/pages/mis_recetas_page.dart';
import 'package:cert3_dam/pages/nueva_receta_page.dart';
import 'package:cert3_dam/pages/principal_page.dart';
import 'package:cert3_dam/pages/recetas_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Stack(children: [
                  Text(
                    'Mystia`s Cookbook',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.brown.shade500,
                    ),
                  ),
                  Text('Mystia`s Cookbook',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade400,
                      ))
                ]),
              ],
            ),
          ),
          backgroundColor: Colors.pink.shade100,
          iconTheme: IconThemeData(color: Colors.orange.shade800),
          bottom: TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.orange.shade800,
              unselectedLabelColor: Colors.pink,
              tabs: [
                Tab(text: 'Home', icon: Icon(Icons.home)),
                Tab(text: 'Recetario', icon: Icon(MdiIcons.bookOpen)),
              ]),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.pink.shade50,
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.pink.shade200, Colors.amber])),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          child: Image.asset('assets/images/mystia11.webp'),
                        )),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Menú principal',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NuevaRecetaPage()));
                  },
                  child: Row(
                    children: [
                      Icon(MdiIcons.plus),
                      SizedBox(width: 10),
                      Text('Nueva receta')
                    ],
                  )),
              Divider(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MisRecetasPage()));
                  },
                  child: Row(
                    children: [
                      Icon(MdiIcons.heart),
                      SizedBox(width: 10),
                      Text('Mis recetas')
                    ],
                  )),
              Divider(),
              TextButton(
                  onPressed: () async {
                    await GoogleSignIn().signOut();
                    FirebaseAuth.instance.signOut();
                  },
                  child: Row(children: [
                    Icon(MdiIcons.close),
                    SizedBox(width: 10),
                    Text('Cerrar sesion')
                  ])),
              // Divider(),
              // TextButton(
              //     onPressed: null,
              //     child: Row(children: [
              //       Icon(MdiIcons.arrowLeft),
              //       SizedBox(width: 10),
              //       Text('Atras')
              //     ])),
            ],
          ),
        ),
        body: TabBarView(children: [PrincipalPage(), RecetasPage()]),
      ),
    );
  }
}
