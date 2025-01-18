import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category_model.dart';
import 'package:shopping_list/models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  var _isSending = false;
  final _formKey = GlobalKey<FormState>();
  String _enteredItem = '';
  var _enteredQuantity = 1;
  var _enteredCategory = categories[Categories.other]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('shopping-list-6a723-default-rtdb.firebaseio.com',
          '/Shopping-List.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: JsonEncoder().convert(
          {
            'name': _enteredItem,
            'quantity': _enteredQuantity,
            'category': _enteredCategory.name,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (context.mounted) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(
          GroceryItems(
              id: responseData['name'],
              name: _enteredItem,
              quantity: _enteredQuantity.toDouble(),
              category: _enteredCategory),
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
              validator: (value) {
                return value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1
                    ? 'Please enter a valid item name'
                    : null;
              },
              onSaved: (value) {
                _enteredItem = value!;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (value) {
                      return value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0
                          ? 'Please enter a valid quantity'
                          : null;
                    },
                    onSaved: (value) {
                      _enteredQuantity = int.parse(value!);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: _enteredCategory,
                    items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                               Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: category.value.color,
                                ),
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(category.value.name),
                            ],
                          ),
                        )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _enteredCategory = value as Category;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSending
                      ? null
                      : () {
                          _formKey.currentState!.reset();
                        },
                  child: const Text('Reset'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _saveItem,
                  child: _isSending
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Add Item'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
