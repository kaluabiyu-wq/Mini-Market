import 'package:mini_market/models/product.dart';

class CartState {
  final List<CartItem> items;
  const CartState(this.items);

  int get count {
    int total = 0;
    for (final item in items) {
      total += item.quantity;
    }
    return total;
  }

  double get total {
    double sum = 0;
    for (final item in items) {
      sum += item.total;
    }
    return sum;
  }
}
