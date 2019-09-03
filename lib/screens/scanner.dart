import 'package:flutter/material.dart';

import 'pulsa.dart';
import 'stocks.dart';

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tian Cell'),
        elevation: 5.0,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _DetailItem(),
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  @override
  __BottomNavBarState createState() => __BottomNavBarState();
}

class __BottomNavBarState extends State<_BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(color: Colors.white, child: _Nav());
  }
}

class _DetailItem extends StatefulWidget {
  const _DetailItem({Key key}) : super(key: key);

  @override
  __DetailItemState createState() => __DetailItemState();
}

class __DetailItemState extends State<_DetailItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[StockCard(), PulsaCard()],
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  const _Nav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.build),
          label: Text('Service'),
          onPressed: () => Navigator.pushNamed(context, '/service'),
        ),
        FlatButton.icon(
          icon: Icon(Icons.photo_camera),
          label: Text('Scan'),
          onPressed: null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.shopping_cart),
          label: Text('Keranjang'),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}
