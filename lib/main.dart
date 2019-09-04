import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/screens/catalog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>(
      builder: (context) => CartModel(),
      child: MaterialApp(
        title: 'Tian Cell',
        home: Catalog(),
      ),
    );
  }
}
