import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BookmarkLocalDataSource {
  Future<void> saveBookmark(Map<String, dynamic> product);

  List<Map<dynamic, dynamic>> getBookmarks();

  ValueListenable<Box> listenBookmarks();
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final Box box;

  BookmarkLocalDataSourceImpl(this.box);

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
