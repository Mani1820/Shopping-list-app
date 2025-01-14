import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    final totalItems = groceryItems.length;

    return ListView.builder(
      itemCount: totalItems, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 18,
          ),
          child: ListTile(
            title: Text(
              groceryItems[index].name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            leading: Container(
              height: 25,
              width: 25,
              color: groceryItems[index].category.color,
            ),
            trailing: Text(
              groceryItems[index].quantity.toString(),
            ),
          ),
        );
      },
    );
  }
}
