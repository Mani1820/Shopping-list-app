//import 'package:flutter/material.dart';
import 'package:shopping_list/models/category_model.dart';

class GroceryItems {
  const GroceryItems({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final double quantity;
  final Category category;
}
