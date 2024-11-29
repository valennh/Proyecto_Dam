import 'package:cert3_dam/services/fb_service.dart';
import 'package:cert3_dam/widgets/receta_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MisRecetasPage extends StatelessWidget {
  const MisRecetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis recetas'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Stack(children: [
        Center(
          child: Image.asset(
            'assets/images/mystia8.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FbService().recetasPorAutor(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var receta = snapshot.data!.docs[index];
                  return Slidable(
                      startActionPane: ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (_) {
                            FbService().borrarReceta(receta.id).then((_) {
                              // Usar directamente el ScaffoldMessenger desde el contexto del Scaffold
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Receta eliminada exitosamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al eliminar la receta: $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                          icon: MdiIcons.trashCan,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          label: 'Eliminar',
                        )
                      ]),
                      child: RecetaTile(receta: receta));
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
