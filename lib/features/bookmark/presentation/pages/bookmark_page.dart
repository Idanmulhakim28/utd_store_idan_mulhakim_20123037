import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/utils/time_formatter.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        backgroundColor: const Color.fromARGB(255, 58, 143, 212),

        title: const Text(
          "Bookmark",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: Hive.box('bookmarks').listenable(),

        builder: (context, box, _) {
          final data = box.values.toList();

          // 🔥 EMPTY STATE
          if (data.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada bookmark",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(14),

            itemCount: data.length,

            itemBuilder: (_, i) {
              final item = Map<String, dynamic>.from(data[i]);

              return Container(
                margin: const EdgeInsets.only(bottom: 14),

                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // 🔥 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.network(
                        item['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 14),

                    // 🔥 INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            item['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Rp ${item['price']}",

                            style: const TextStyle(
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // 🔥 TIMESTAMP PERSONAL
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 15,
                                color: Colors.grey,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                "Disimpan pada ${formatTime(DateTime.parse(item['saved_at']))}",

                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 🔥 ICON BOOKMARK
                    const Icon(Icons.bookmark, color: Colors.red, size: 28),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
