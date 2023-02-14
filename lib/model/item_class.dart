import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'item_class.freezed.dart';
part 'item_class.g.dart';

// クラスの作成
@freezed
class Item with _$Item {
  // データの内容
  const factory Item({
    required String title,
    required String description,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
