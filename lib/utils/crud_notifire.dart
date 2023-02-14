import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/model/item_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifierクラスを使うためのProvider.
final crudProvider = NotifierProvider<Crud, List<Item>>(Crud.new);

// Firestoreを操作するNotifierクラス
class Crud extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  // Firestoreのコレクションにアクセスする変数.
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection('item');

  // Firestoreにデータを追加するメソッド.
  Future<DocumentReference> addItem(String title, String description) async {
    final now = DateTime.now();
    return await collection.add({
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(now),
    });
  }

  // Firestoreのデータを更新するメソッド.
  Future<void> updateItem(String id, String title, String description) async {
    final now = DateTime.now();
    await collection.doc(id).update({
      'title': title,
      'description': description,
      'updatedAt': Timestamp.fromDate(now),
    });
  }

  // Firestoreのデータを削除するメソッド.
  Future<void> deleteItem(String id) async {
    await collection.doc(id).delete();
  }
}
