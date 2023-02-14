import 'package:counter/ui/item_detail.dart';
import 'package:counter/utils/firestoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemList extends ConsumerWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemStreamProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('アイテムリスト'),
        ),
        body: Center(
            child: Column(
          children: [
            Expanded(
                child: items.when(
                    data: (items) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              title: Text(item.title),
                              subtitle: Text(item.description),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetail(item: item)));
                              },
                            );
                          });
                    },
                    error: (error, stack) => Text('Error: $error'),
                    loading: () => const CircularProgressIndicator()))
          ],
        )));
  }
}
