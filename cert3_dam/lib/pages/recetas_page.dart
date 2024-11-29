import 'package:cert3_dam/services/fb_service.dart';
import 'package:cert3_dam/widgets/receta_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecetasPage extends StatelessWidget {
  const RecetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Conoce los detalles de cada receta dando click sobre ella!',
      //     style: TextStyle(fontSize: 13),
      //   ),
      // ),
      body: Stack(children: [
        Center(
          child: Image.asset(
            'assets/images/mystia7.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FbService().recetas(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var receta = snapshot.data!.docs[index];
                  return RecetaTile(receta: receta);
                  // return Slidable(
                  //     endActionPane:
                  //         ActionPane(motion: ScrollMotion(), children: [
                  //       SlidableAction(
                  //         onPressed: (context) {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => DetalleRecetaPage()));
                  //         },
                  //         icon: MdiIcons.eye,
                  //         foregroundColor: Colors.white,
                  //         backgroundColor: Colors.green,
                  //         label: 'Ver',
                  //       )
                  //     ]),
                  //     startActionPane:
                  //         ActionPane(motion: ScrollMotion(), children: [
                  //       SlidableAction(
                  //         onPressed: (context) {
                  //           FbService().borrarReceta(receta.id);
                  //         },
                  //         icon: MdiIcons.trashCan,
                  //         foregroundColor: Colors.white,
                  //         backgroundColor: Colors.red,
                  //         label: 'Eliminar',
                  //       )
                  //     ]),
                  //     child: RecetaTile(receta: receta)
                },
              );
            },
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 500, left: 270),
            child: Image.asset(
              'assets/images/mystia9.webp',
              width: 600,
              height: 600,
            ))
      ]),
    );
  }
}
