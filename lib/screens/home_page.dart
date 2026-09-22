import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_market/blocs/cart_bloc.dart';
import 'package:mini_market/blocs/cart_state.dart';
import 'package:mini_market/blocs/product_bloc.dart';
import 'package:mini_market/blocs/product_state.dart';
import 'package:mini_market/screens/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Market'),
        actions: [
          IconButton(
            onPressed: () => context.push('/cart'),
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                return Badge(
                  isLabelVisible: cartState.count > 0,
                  label: Text(cartState.count.toString()),
                  child: const Icon(Icons.shopping_cart),
                );
              },
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.all(8),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            final products = productState.products;

            return GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];

                return ProductCard(
                  product: product,
                  onTap: () => context.push('/product/${product.id}'),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
