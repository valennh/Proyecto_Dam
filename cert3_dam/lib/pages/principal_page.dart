import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> carImg = [
      'assets/images/mystia1.gif',
      'assets/images/mystia4.png',
      'assets/images/mystia5.png',
      'assets/images/mystia6.png',
    ];
    return Scaffold(
        body: Stack(children: [
      Center(
        child: Image.asset(
          'assets/images/mystia2.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Opacity(
          opacity: 0.9,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                gradient: LinearGradient(
                    colors: [Colors.pink.shade200, Colors.orange]),
                // color: Colors.black,
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  'Bienvenida al libro de recetas de Mystia Lorelei!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Sus mejores recetas ahora disponibles en un solo lugar!\n Además, agrega tus propias creaciones al recetario',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 200, left: 30, right: 30),
        child: Container(
          height: 200,
          child: CarouselSlider(
              options: CarouselOptions(autoPlay: true),
              items: carImg
                  .map((item) => Container(
                        // margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList()),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 400, left: 70, right: 30),
        child: Column(
          children: [
            Text(
              'Conjunto del mes:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Vota cada mes para elegir el conjunto de Mystia!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            Image.asset('assets/images/mystia6.webp')
          ],
        ),
      )
    ]));
  }
}
