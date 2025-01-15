import 'package:flutter/material.dart';
import 'package:shopping_list/widget/grocery_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GroceryList();
  }
}
