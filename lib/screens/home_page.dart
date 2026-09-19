import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/screens/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final products = MarketStore.products;

  Future<void> _openCart() async {
    await context.push('/cart');

    setState(() {});
  }

 

  Future<void> _openProduct({required String id}) async {
     await context.push('/product/$id');

    setState(() {});
  }

  Future<void> _openProductForm() async {
     await context.push('/add');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = MarketStore.cartCount;
    final products = MarketStore.products;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mini Market"),
        actions: [
          IconButton(
            onPressed: _openCart,
            icon: Badge(
              isLabelVisible: itemCount > 0,
              label: Text(itemCount.toString()),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.all(8),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];

            return ProductCard(
              product: product,
              onTap: () => _openProduct(id: product.id),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openProductForm,
        child: Icon(Icons.add),
      ),
    );
  }
}
