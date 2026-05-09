import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final Box box;

  BookmarkRepositoryImpl(this.box);

  @override
  Future<void> saveBookmark(Map<String, dynamic> product) async {
    await box.add(product);
  }

  @override
  List<Map<dynamic, dynamic>> getBookmarks() {
    return box.values.map((e) => Map<dynamic, dynamic>.from(e)).toList();
  }

  @override
  ValueListenable<Box> listenBookmarks() {
    return box.listenable();
  }
}
