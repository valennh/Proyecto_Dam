import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbService {
  Stream<QuerySnapshot> recetas() {
    return FirebaseFirestore.instance.collection('recetas').snapshots();
  }

  Stream<QuerySnapshot> recetasPorAutor() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance.collection('recetas').where('autor', isEqualTo: user.displayName).snapshots();
    } else {
      return Stream.empty();
    }
  }

  Stream<QuerySnapshot> fotos() {
    return FirebaseFirestore.instance.collection('fotos').snapshots();
  }

  Stream<DocumentSnapshot> recetaConId(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> categoria(String cat) {
    return FirebaseFirestore.instance.collection('categorias').where('preparacion', isEqualTo: cat).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> categorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }

  Future<void> nuevaReceta(String nombre, String inst, String foto, String autor, String cat) {
    return FirebaseFirestore.instance.collection('recetas').doc().set({'nombre': nombre, 'instrucciones': inst, 'foto': foto, 'autor': autor, 'categoria': cat});
  }

  Future<void> borrarReceta(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).delete();
  }
}
