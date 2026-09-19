import 'package:flutter/material.dart';
import 'package:mini_market/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
  
      title: 'Mini Market',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
