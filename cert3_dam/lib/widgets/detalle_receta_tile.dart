import 'package:cert3_dam/services/fb_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetalleRecetaTile extends StatelessWidget {
  const DetalleRecetaTile({super.key, required this.recetaId});

  final String recetaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FbService().recetaConId(recetaId),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var receta = snapshot.data!.data() as Map<String, dynamic>;
            return Expanded(
              child: Stack(children: [
                Opacity(
                  opacity: 0.9,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [Colors.pink.shade200, Colors.orange])),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/${receta['foto']}',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        receta['nombre'],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        'Por: ${receta['autor']}',
                        style: TextStyle(
                            color: Colors.grey.shade900, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Instrucciones de preparacion: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            receta['instrucciones'],
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Tipo de preparacion (categoría): ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FbService().categoria(receta['categoria']),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              var docu = snapshot.data!.docs;
                              var cat = docu.first.data();
                              return Column(children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    receta['categoria'],
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                    child: Image.asset(
                                  'assets/images/${cat['foto']}',
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                )),
                              ]);
                            }),
                      ],
                    )
                  ],
                ),
              ]),
            );
          }),
    );
  }
}
