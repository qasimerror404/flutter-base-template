import 'package:isar/isar.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

/// Product model for data layer (includes Isar annotations)
@collection
class ProductModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String productId;

  late String title;
  late String description;
  late double price;
  String? image;
  String? category;
  double? rating;
  late bool isFavorite;

  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id = Isar.autoIncrement,
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    this.image,
    this.category,
    this.rating,
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// Convert from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String?,
      category: json['category'] as String?,
      rating: json['rating'] is Map
          ? (json['rating']['rate'] as num?)?.toDouble()
          : (json['rating'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
      'isFavorite': isFavorite,
    };
  }

  /// Convert to entity
  Product toEntity() {
    return Product(
      id: productId,
      title: title,
      description: description,
      price: price,
      image: image,
      category: category,
      rating: rating,
      isFavorite: isFavorite,
    );
  }

  /// Convert from entity
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      productId: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      image: product.image,
      category: product.category,
      rating: product.rating,
      isFavorite: product.isFavorite,
    );
  }

  /// Copy with method
  ProductModel copyWith({
    Id? id,
    String? productId,
    String? title,
    String? description,
    double? price,
    String? image,
    String? category,
    double? rating,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

