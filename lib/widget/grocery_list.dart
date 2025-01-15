import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery.dart';
import 'package:shopping_list/screens/new_item_screen.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItems> groceryItem = [];
  void _addNewItem(BuildContext context) async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItemScreen(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItems item) {
    setState(() {
      groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    final totalItems = groceryItem.length;
    Widget content = const Center(
      child: Text(
        'No items added yet!',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
    if (groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: totalItems,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 18,
            ),
            child: Dismissible(
              key: ValueKey(groceryItem[index].id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _removeItem(groceryItem[index]),
              child: ListTile(
                title: Text(
                  groceryItem[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: groceryItem[index].category.color,
                  ),
                  height: 25,
                  width: 25,
                ),
                trailing: Text(
                  groceryItem[index].quantity.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Shopping List',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addNewItem(context);
            },
          ),
        ],
        backgroundColor: Theme.of(context).copyWith().colorScheme.onPrimary,
      ),
      backgroundColor: Theme.of(context).copyWith().colorScheme.surface,
      body: content,
    );
  }
}
