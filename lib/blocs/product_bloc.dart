import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/blocs/product_event.dart';
import 'package:mini_market/blocs/product_state.dart';
import 'package:mini_market/models/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(_seedProducts)) {
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  static final List<Product> _seedProducts = [
    const Product(
      id: 'p1',
      title: 'Phone X',
      price: 549,
      category: 'smartphones',
      description: '6.1-inch display, 128 GB storage, dual camera.',
    ),
    const Product(
      id: 'p2',
      title: 'Headphones',
      price: 89,
      category: 'audio',
      description: 'Over-ear headphones with 30 hours of battery life.',
    ),
    const Product(
      id: 'p3',
      title: 'T-shirt',
      price: 15,
      category: 'clothing',
      description: '100% cotton, regular fit, machine washable.',
    ),
    const Product(
      id: 'p4',
      title: 'Laptop',
      price: 899,
      category: 'computers',
      description: '14-inch laptop, 16 GB RAM, 512 GB SSD.',
    ),
    const Product(
      id: 'p5',
      title: 'Camera',
      price: 320,
      category: 'photography',
      description: 'Compact camera with 20x optical zoom.',
    ),
    const Product(
      id: 'p6',
      title: 'Backpack',
      price: 42,
      category: 'accessories',
      description: 'Water resistant backpack with a laptop pocket.',
    ),
  ];

  Product? findProduct(String id) {
    for (final product in state.products) {
      if (product.id == id) return product;
    }
    return null;
  }

  String newProductId() => 'p${DateTime.now().millisecondsSinceEpoch}';

  void _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) {
    emit(ProductState([...state.products, event.product]));
  }

  void _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) {
    final products = state.products
        .map((p) => p.id == event.product.id ? event.product : p)
        .toList();
    emit(ProductState(products));
  }

  void _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) {
    final products =
        state.products.where((p) => p.id != event.productId).toList();
    emit(ProductState(products));
  }
}
