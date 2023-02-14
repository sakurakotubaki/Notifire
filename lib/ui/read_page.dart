import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/ui/item_list.dart';
import 'package:counter/utils/crud_notifire.dart';
import 'package:counter/utils/item_prvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadPage extends ConsumerWidget {
  const ReadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Firestoreの値を全て取得するProvider.
    final item = ref.watch(itemProvider);
    // Formの値を保存するTextEditingController.
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテムを表示'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: title,
            ),
            TextField(
              controller: description,
            ),
            ElevatedButton(
                onPressed: () async {
                  // Firestoreにデータを保存.
                  ref
                      .read(crudProvider.notifier)
                      .addItem(title.text, description.text);
                },
                child: Text('アイテムを追加')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ItemList()));
                },
                child: Text('詳細ページへ')),
            const SizedBox(height: 20),
            item.when(
              // データがあった（データはqueryの中にある）
              data: (QuerySnapshot query) {
                // ExpandedでListViewをWrapしないとエラーが発生する!
                // Listのサイズが多くなったときに、最大サイズを引き伸ばす.
                return Expanded(
                  child: ListView(
                    children: query.docs.map((document) {
                      return Card(
                        child: ListTile(
                          // itemで送った内容を表示する
                          title: Text(document['title']),
                          subtitle: Text(document['description']),
                          // CardWidgetにボタンを２個配置できるように、
                          // SizedBoxとRowでWrapする
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // 編集用Modal
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 400,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text('Modal BottomSheet'),
                                                TextFormField(
                                                  controller: title,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: 'アイテムを入力',
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: description,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: '解説を入力してください',
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      // ドキュメントidを取得する変数.
                                                      final id =
                                                          document.reference.id;
                                                      // Firestoreのデータを更新する.
                                                      ref
                                                          .read(crudProvider
                                                              .notifier)
                                                          .updateItem(
                                                              id,
                                                              title.text,
                                                              description.text);
                                                    },
                                                    child: const Text('編集')),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  child: const Text('閉じる'),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    // ドキュメントidを取得する変数.
                                    final id = document.reference.id;
                                    // Firestoreの値を削除する.
                                    ref
                                        .read(crudProvider.notifier)
                                        .deleteItem(id);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
              // データの読み込み中（FireStoreではあまり発生しない）
              loading: () {
                return const Text('Loading');
              },

              // エラー（例外発生）時
              error: (e, stackTrace) {
                return Text('error: $e');
              },
            )
          ],
        ),
      ),
    );
  }
}
