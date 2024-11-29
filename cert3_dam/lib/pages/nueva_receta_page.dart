import 'package:cert3_dam/services/fb_service.dart';
import 'package:flutter/material.dart';

class NuevaRecetaPage extends StatefulWidget {
  const NuevaRecetaPage({super.key});

  @override
  State<NuevaRecetaPage> createState() => _NuevaRecetaPageState();
}

class _NuevaRecetaPageState extends State<NuevaRecetaPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController instCtrl = TextEditingController();
  TextEditingController fotoCtrl = TextEditingController();
  TextEditingController autorCtrl = TextEditingController();
  TextEditingController catCtrl = TextEditingController();

  //se debe agregar campo de categoria (comboBox), yo por mientras le puse un Texteditingcontroller para probar si estaba funcionando bien,
  //OJO el valor que devuelve el combobox DEBE ser string
//la receta al mostrarse en el listado de recetas debe tener un autor, que se autocompleta dependiendo del dueno de la cuenta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Agregar nueva receta',
          ),
          backgroundColor: Colors.pink.shade100,
        ),
        body: Stack(children: [
          Image.asset(
            'assets/images/mystia10.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (nombre) {
                          if (nombre!.isEmpty) {
                            return 'El nombre es requerido';
                          }
                          return null;
                        },
                        controller: nombreCtrl,
                        decoration: InputDecoration(
                          labelText: 'Nombre de la receta',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (inst) {
                          if (inst!.isEmpty) {
                            return 'Las intrucciones son requeridas';
                          }
                          return null;
                        },
                        controller: instCtrl,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: 'Intrucciones de la receta',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (foto) {
                          if (foto!.isEmpty) {
                            return 'La foto es requerida';
                          }
                          return null;
                        },
                        controller: fotoCtrl,
                        decoration: InputDecoration(
                          labelText:
                              'Foto refencial del platillo (dejar ruta asset)',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (autor) {
                          if (autor!.isEmpty) {
                            return 'El autor es requerido';
                          }
                          return null;
                        },
                        controller: autorCtrl,
                        decoration: InputDecoration(
                          labelText: 'Autor de la receta',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        validator: (cat) {
                          if (cat!.isEmpty) {
                            return 'La categoria es requerida';
                          }
                          return null;
                        },
                        controller: catCtrl,
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                        ),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          // form ya validado
                          if (formKey.currentState!.validate()) {
                            FbService()
                                .nuevaReceta(
                              nombreCtrl.text.trim(),
                              instCtrl.text.trim(),
                              fotoCtrl.text.trim(),
                              autorCtrl.text.trim(),
                              catCtrl.text.trim(),
                            )
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Receta agregada exitosamente'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              nombreCtrl.clear();
                              instCtrl.clear();
                              fotoCtrl.clear();
                              autorCtrl.clear();
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Error al agregar receta: $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          }
                        },
                        child: Text('Agregar'))
                  ],
                )),
          ),
        ]));
  }
}
