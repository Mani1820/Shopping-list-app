import 'package:flutter/material.dart';
import 'package:shopping_list/screens/new_item_screen.dart';
import 'package:shopping_list/widget/grocery_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void _addNewItem(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewItemScreen(),),);
  }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: (){
              _addNewItem(context);
            },
          ),
        ],
        backgroundColor: Theme.of(context).copyWith().colorScheme.onPrimary,
      ),
      backgroundColor:
          Theme.of(context).copyWith().colorScheme.surface,
      body:const GroceryList(),
    );
  }
}
