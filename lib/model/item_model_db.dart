import 'package:hive/hive.dart';

part 'item_model_db.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String costPrice;

  @HiveField(2)
  late String salePrice;

  @HiveField(3)
  late String id;

  @HiveField(4)
  late String quantity;

  ItemModel({
    required this.title,
    required this.costPrice,
    required this.salePrice,
    required this.id,
    required this.quantity,
  });

  // CopyWith method to create a copy of the object with some fields replaced
  ItemModel copyWith({
    String? title,
    String? costPrice,
    String? salePrice,
    String? id,
    String? quantity,
  }) {
    return ItemModel(
      title: title ?? this.title,
      costPrice: costPrice ?? this.costPrice,
      salePrice: salePrice ?? this.salePrice,
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
