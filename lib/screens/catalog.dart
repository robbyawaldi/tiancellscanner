import 'package:flutter/material.dart';

import 'cart.dart';
import 'pulsa.dart';
import 'services.dart';
import 'stocks.dart';

class Catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.view_agenda)),
              Tab(icon: Icon(Icons.shopping_basket)),
            ],
          ),
          title: Text('Tian Cell'),
          backgroundColor: Colors.indigo,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: _Cards(),
            ),
            Cart(),
          ],
        ),
      ),
    );
  }
}

class _Cards extends StatefulWidget {
  const _Cards({Key key}) : super(key: key);

  @override
  __CardsState createState() => __CardsState();
}

class __CardsState extends State<_Cards> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[StockCard(), PulsaCard(), ServiceCard()],
      ),
    );
  }
}
