import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewRepository {
  void addPost(String review) async {
    final ref = FirebaseFirestore.instance;
    final docRef = await ref.collection('item').doc('2CL7ADy63VQBG5dA4RFP');
    await ref.collection('review').doc().set({
      'title': review,
      'reference': docRef,
    });
  }
}
