import 'package:cert3_dam/pages/detalle_receta_page.dart';
import 'package:flutter/material.dart';

class RecetaTile extends StatelessWidget {
  const RecetaTile({super.key, required this.receta});

  final dynamic receta;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        opacity: 0.9,
        child: Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          padding: EdgeInsets.all(5),
          height: 240,
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
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/${receta['foto']}'),
          ),
          ListTile(
            title: Text(
              receta['nombre'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              'Por: ${receta['autor']}',
              style: TextStyle(color: Colors.grey.shade900),
              textAlign: TextAlign.center,
            ),
          ),
          FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalleRecetaPage(
                              recetaId: receta.id,
                            )));
              },
              child: Text('Cocinar'))
        ],
      ),
    ]);
  }
}
