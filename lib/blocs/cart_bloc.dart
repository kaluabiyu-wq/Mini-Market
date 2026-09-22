import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/blocs/cart_event.dart';
import 'package:mini_market/blocs/cart_state.dart';
import 'package:mini_market/models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState([])) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.product.id == event.product.id);

    if (index == -1) {
      items.add(CartItem(product: event.product, quantity: event.quantity));
    } else {
      final existing = items[index];
      items[index] = CartItem(
        product: existing.product,
        quantity: existing.quantity + event.quantity,
      );
    }

    emit(CartState(items));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final items =
        state.items.where((item) => item.product.id != event.productId).toList();
    emit(CartState(items));
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartState([]));
  }
}
