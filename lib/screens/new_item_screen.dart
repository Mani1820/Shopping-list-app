import 'package:flutter/material.dart';

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
          Theme.of(context).copyWith().colorScheme.onInverseSurface,
      body: const Center(
        child: Text(
          'Add New Item',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}