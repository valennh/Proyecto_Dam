import 'package:cert3_dam/services/fb_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String categoriaSeleccioanda = '';
  String fotoSeleccionada = '';

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
                      child: StreamBuilder(
                        stream: FbService().fotos(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                            return Text('Cargando fotos...');
                          }

                          var fotos = snapshot.data!.docs;
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Seleccione foto'),
                            value: null,
                            onChanged: (value) {
                              fotoSeleccionada = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Seleccione foto';
                              }
                              return null;
                            },
                            items: fotos.map<DropdownMenuItem<String>>((foto) {
                              return DropdownMenuItem<String>(
                                child: Text(foto['nombre']),
                                value: foto['foto'],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: StreamBuilder(
                        stream: FbService().categorias(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                            return Text('Cargando categorias...');
                          }

                          var categorias = snapshot.data!.docs;
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(labelText: 'Seleccione categoria'),
                            value: null,
                            onChanged: (value) {
                              categoriaSeleccioanda = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Seleccione categoria';
                              }
                              return null;
                            },
                            items: categorias.map<DropdownMenuItem<String>>((categoria) {
                              return DropdownMenuItem<String>(
                                child: Text(categoria['preparacion']),
                                value: categoria['preparacion'],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    FilledButton(
                        onPressed: () {
                          User? user = FirebaseAuth.instance.currentUser;
                          String userName = user!.displayName ?? 'No name';

                          // form ya validado
                          if (formKey.currentState!.validate()) {
                            FbService().nuevaReceta(nombreCtrl.text.trim(), instCtrl.text.trim(), fotoSeleccionada, userName, categoriaSeleccioanda).then((_) {
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
                                  content: Text('Error al agregar receta: $error'),
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
