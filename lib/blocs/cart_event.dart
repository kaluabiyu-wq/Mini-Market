import 'package:mini_market/models/product.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;
  AddToCartEvent(this.product, this.quantity);
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;
  RemoveFromCartEvent(this.productId);
}

class ClearCartEvent extends CartEvent {}
