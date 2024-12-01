import 'package:cert3_dam/widgets/detalle_receta_tile.dart';
import 'package:flutter/material.dart';

class DetalleRecetaPage extends StatelessWidget {
  const DetalleRecetaPage({super.key, required this.recetaId});

  final dynamic recetaId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle receta'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/mystia9.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              child: DetalleRecetaTile(recetaId: recetaId),
            ),
          )
        ],
      ),
    );
  }
}
