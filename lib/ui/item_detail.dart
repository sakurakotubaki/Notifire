import 'package:counter/model/item_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetail extends ConsumerWidget {
  // ListView.builderから値を受け取れるように、コンストラクターを定義する
  const ItemDetail({super.key, required this.item});
  // 受け取った値を保存する変数を作る
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('詳細ページ'),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          // 受け取った値を保存した変数を使って、Userクラスのプロパティを表示できるようにする
          Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Text(
              '${item.title}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 20),
            alignment: Alignment.topLeft,
            child: Text(
              '${item.description}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
