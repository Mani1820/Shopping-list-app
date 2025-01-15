import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category_model.dart';
import 'package:shopping_list/models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  String _enteredItem = '';
  var _enteredQuantity = 1;
  var _enteredCategory = categories[Categories.other]!;
  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItems(
            id: DateTime.now().toString(),
            name: _enteredItem,
            quantity: _enteredQuantity.toDouble(),
            category: _enteredCategory),
      );
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
                        _enteredCategory = value!;
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
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  child: Text('Reset'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _saveItem,
                  child: Text('Add Item'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
