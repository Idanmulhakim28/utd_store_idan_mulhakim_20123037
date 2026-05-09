class BookmarkModel {
  final int productId;
  final String title;
  final String image;
  final double price;
  final DateTime createdAt;

  BookmarkModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      productId: map['productId'],
      title: map['title'],
      image: map['image'],
      price: map['price'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
