import 'package:go_router/go_router.dart';
import 'package:mini_market/models/product.dart';
import 'package:mini_market/screens/add_product.dart';
import 'package:mini_market/screens/cart_page.dart';
import 'package:mini_market/screens/home_page.dart';
import 'package:mini_market/screens/product_details.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/',
    builder: (context, state) => const HomePage(),),

    GoRoute(path: '/product/:id',
    builder: (context, state)=> ProductDetails(productId: 
    state.pathParameters['id']!,),
    ),

    GoRoute(path: '/add',
    builder: (context, state)=> AddProduct(
      existingProduct: state.extra as Product?,
    ),
    ),

    GoRoute(path: '/cart', 
    
    builder:(context,state)=> const CartPage(),
     ),


  ]
);