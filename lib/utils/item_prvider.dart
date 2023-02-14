import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemProvider = StreamProvider.autoDispose((_) {
  return FirebaseFirestore.instance.collection('item').snapshots();
});
