import 'package:cloud_firestore/cloud_firestore.dart';

class FbService {
  Stream<QuerySnapshot> recetas() {
    return FirebaseFirestore.instance.collection('recetas').snapshots();
  }

  Stream<DocumentSnapshot> recetaConId(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> categoria(String cat) {
    return FirebaseFirestore.instance
        .collection('categorias')
        .where('preparacion', isEqualTo: cat)
        .snapshots();
  }

  Future<void> nuevaReceta(
      String nombre, String inst, String foto, String autor, String cat) {
    return FirebaseFirestore.instance.collection('recetas').doc().set({
      'nombre': nombre,
      'instrucciones': inst,
      'foto': foto,
      'autor': autor,
      'categoria': cat
    });
  }

  Future<void> borrarReceta(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).delete();
  }
}
