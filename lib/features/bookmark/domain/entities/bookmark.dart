import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/bookmark_model.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),

      body: ValueListenableBuilder(
        valueListenable: Hive.box('bookmarks').listenable(),
        builder: (context, box, _) {
          final items = box.values.toList();

          if (items.isEmpty) {
            return const Center(child: Text("Belum ada bookmark"));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final item = BookmarkModel.fromMap(
                Map<String, dynamic>.from(items[i]),
              );

              return ListTile(
                leading: Image.network(item.image, width: 50),
                title: Text(item.title),
                subtitle: Text("Disimpan pada ${formatTime(item.createdAt)}"),
                trailing: Text("Rp ${item.price}"),
              );
            },
          );
        },
      ),
    );
  }
}
