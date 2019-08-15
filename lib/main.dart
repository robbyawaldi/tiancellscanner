import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/screens/cart.dart';
import 'package:tiancell/screens/scanner.dart';
import 'package:tiancell/screens/service.dart';

import 'models/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemModel>(
          builder: (context) => ItemModel(),
        ),
        ChangeNotifierProvider<CartModel>(
          builder: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Tian Cell',
        initialRoute: '/',
        routes: {
          '/': (context) => Scanner(),
          '/cart': (context) => Cart(),
          '/service': (context) => Service(),
        },
      ),
    );
  }
}
