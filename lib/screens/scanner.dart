import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/models/item.dart';
import 'package:tiancell/models/model.dart';

import 'format.dart';

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
  int _qty = 1;

  void minus() {
    setState(() {
      if (_qty != 1) _qty--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var item = Provider.of<ItemModel>(context);
    var cart = Provider.of<CartModel>(context);

    void add() {
      setState(() {
        if (_qty < item.item.stock) _qty++;
      });
    }

    if (item.item != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 120),
            Container(
              height: 250,
              width: 279,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.item.name.toUpperCase(),
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${rupiah(item.item.price).formattedLeftSymbol}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Jumlah',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.black,
                            onPressed: minus,
                            splashColor: Colors.white,
                          ),
                          Text('$_qty', style: new TextStyle(fontSize: 14.0)),
                          IconButton(
                            onPressed: add,
                            icon: Icon(Icons.add),
                            color: Colors.black,
                            splashColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: 70,
                            child: FlatButton(
                              child: Text('Batal'),
                              onPressed: item.remove,
                            ),
                          ),
                          FlatButton(
                            color: Colors.orange[600],
                            textColor: Colors.white,
                            child: Text('Tambah ke Keranjang'),
                            onPressed: item.item.stock < 1
                                ? null
                                : () {
                                    cart.add(item.item, _qty);
                                    item.remove();
                                    setState(() => _qty = 1);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'Item berhasil ditambahkan ke keranjang')));
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: Text(
              'Have a nice day 😀',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Image.asset('happy.png', fit: BoxFit.cover, width: double.infinity),
          FutureBuilder<List<Item>>(
            future: item.items(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return DropdownButton<Item>(
                items: snapshot.data
                    .map(
                      (item) => DropdownMenuItem<Item>(
                        child: Text(item.name),
                        value: item,
                      ),
                    )
                    .toList(),
                onChanged: (Item value) => item.itemById(value.id.toString()),
                hint: Text('Pilih Barang'),
              );
            },
          ),
          SizedBox(height: 10),
        ],
      );
  }
}

class _Nav extends StatelessWidget {
  const _Nav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = Provider.of<ItemModel>(context);

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
          onPressed: item.scan,
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
