import 'package:equatable/equatable.dart';

/// Product entity (domain model)
class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String? image;
  final String? category;
  final double? rating;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.category,
    this.rating,
    this.isFavorite = false,
  });

  /// Copy with method
  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? image,
    String? category,
    double? rating,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        image,
        category,
        rating,
        isFavorite,
      ];

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price)';
  }
}

