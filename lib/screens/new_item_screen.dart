import 'package:flutter/material.dart';
import 'package:shopping_list/widget/new_item.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Item',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).copyWith().colorScheme.onPrimary,
      ),
      backgroundColor:
          Theme.of(context).copyWith().colorScheme.surface,
      body: const NewItem(),
    );
  }
}