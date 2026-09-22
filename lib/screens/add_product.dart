import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/blocs/product_bloc.dart';
import 'package:mini_market/blocs/product_event.dart';
import 'package:mini_market/data/categories.dart';
import 'package:mini_market/models/product.dart';


class AddProduct extends StatefulWidget {
  final Product? existingProduct;
  const AddProduct({super.key, this.existingProduct});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
   final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late String _category;

  bool get _isEditing => widget.existingProduct != null;

  @override
  void initState() {
    super.initState();
     final existing = widget.existingProduct;
    _titleController = TextEditingController(text: existing?.title ?? '');
    _priceController = TextEditingController(
      text: existing != null ? existing.price.toString() : '',
    );
    _descriptionController = TextEditingController(
      text: existing?.description ?? '',
    );
    _category = existing?.category ?? kCategories.first;
  }

  @override
  void dispose() {
     _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
     if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _titleController.text.trim();
    final price = double.parse(_priceController.text.trim());
    final description = _descriptionController.text.trim();

    final productBloc = context.read<ProductBloc>();

    if (_isEditing) {
      productBloc.add(
        UpdateProductEvent(
          widget.existingProduct!.copyWith(
            title: title,
            price: price,
            category: _category,
            description: description,
          ),
        ),
      );
    } else {
      productBloc.add(
        AddProductEvent(
          Product(
            id: productBloc.newProductId(),
            title: title,
            price: price,
            category: _category,
            description: description,
          ),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        title: Text(_isEditing ? 'Edit product' : 'Add product'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Title', style: _labelStyle),
            const SizedBox(height: 6),
            TextFormField(
              controller: _titleController,
              decoration: _fieldDecoration(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text('Price', style: _labelStyle),
            const SizedBox(height: 6),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _fieldDecoration(),
              validator: (value) {
                final parsed = double.tryParse((value ?? '').trim());
                if (parsed == null || parsed < 0) {
                  return 'Enter a valid price';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            const Text('Category', style: _labelStyle),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: _fieldDecoration(),
              items: kCategories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 20),

            const Text('Description', style: _labelStyle),
            const SizedBox(height: 6),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: _fieldDecoration(hint: 'Short description'),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _save,
              child: Text(
                _isEditing ? 'Save changes' : 'Save product',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _labelStyle = TextStyle(color: Colors.grey);

InputDecoration _fieldDecoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );
}
