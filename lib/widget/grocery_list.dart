import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery.dart';
import 'package:shopping_list/screens/new_item_screen.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItems> groceryItem = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  void loadItems() async {
    final url = Uri.https(
      'shopping-list-6a723-default-rtdb.firebaseio.com',
      '/Shopping-List.json',
    );
    final response = await http.get(url);
    final Map<String, dynamic> listItems = json.decode(response.body);

    List<GroceryItems> loadedItems = [];

    for (final item in listItems.entries) {
      final category = categories.entries
          .firstWhere((element) => element.value.name == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItems(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(
      () {
        groceryItem = loadedItems;
      },
    );
  }

  void _addNewItem(BuildContext context) async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItemScreen(),
      ),
    );
    if (newItem != null) {
      setState(() {
        groceryItem.add(newItem);
      });
    }
    return;
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
