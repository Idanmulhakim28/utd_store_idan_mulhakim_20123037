import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BookmarkRepository {
  Future<void> saveBookmark(Map<String, dynamic> product);

  List<Map<dynamic, dynamic>> getBookmarks();

  ValueListenable<Box> listenBookmarks();
}
