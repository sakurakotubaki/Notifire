import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/item_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemStreamProvider = StreamProvider<List<Item>>((ref) {
  // FireStoreの全てのデータを取得.
  final collection = FirebaseFirestore.instance.collection('item');
  // データ（Map型）を取得.
  final stream = collection.snapshots().map(
        // CollectionのデータからItemクラスを生成する.
        (e) => e.docs.map((e) => Item.fromJson(e.data())).toList(),
      );
  return stream;
});
