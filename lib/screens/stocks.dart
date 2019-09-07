import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_utils/qr_utils.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/models/item.dart';
import 'package:tiancell/models/sale.dart';

import 'format.dart';

class StockCard extends StatefulWidget {
  const StockCard({Key key}) : super(key: key);

  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  Item _item;
  int _qty;

  @override
  void initState() {
    _qty = 1;
    super.initState();
  }

  void add() {
    setState(() {
      if (_qty < _item?.stock ?? 0) _qty++;
    });
  }

  void minus() {
    setState(() {
      if (_qty != 1) _qty--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return SizedBox(
      height: _item != null ? 223 : 130,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _item == null
              ? _selectItem()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Item name
                    Text(
                      _item.name.toUpperCase(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // Item price
                    Text(
                      '${rupiah(_item.price).formattedLeftSymbol}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Expanded(child: SizedBox()),
                    // Item qty
                    _selectQuantity(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // Cancel button
                        SizedBox(
                          width: 70,
                          child: FlatButton(
                            child: Text('Batal'),
                            onPressed: () {
                              setState(() => _item = null);
                            },
                          ),
                        ),
                        // Add button
                        FlatButton.icon(
                          icon: Icon(Icons.add),
                          color: Colors.orange[600],
                          textColor: Colors.white,
                          label: Text('Tambah ke Keranjang'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: _item.stock < 1 ||
                                  cart.list
                                      .where((item) => item is Sale)
                                      .contains(_item)
                              ? null
                              : () {
                                  cart.addSale(_item, _qty);
                                  setState(() {
                                    _item = null;
                                  });
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Item berhasil ditambahkan ke keranjang'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _selectItem() {
    return FutureBuilder<List<Item>>(
      future: ItemModel().items(),
      builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Item', style: Theme.of(context).textTheme.headline),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<Item>(
                  items: snapshot.data
                      .map((item) => DropdownMenuItem<Item>(
                            child: Text(item.name),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (Item item) {
                    setState(() {
                      _item = item;
                    });
                  },
                  hint: Text('Pilih Item'),
                ),
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    await QrUtils.scanQR.then((id) {
                      if (id != null)
                        ItemModel()
                            .getById(id)
                            .then((item) => setState(() => _item = item));
                    });
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _selectQuantity() {
    return Row(
      children: <Widget>[
        Text(
          'Jumlah',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
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
          iconSize: 28,
        ),
        Text('$_qty', style: new TextStyle(fontSize: 18.0)),
        IconButton(
          onPressed: add,
          icon: Icon(Icons.add),
          color: Colors.black,
          splashColor: Colors.white,
          iconSize: 28,
        ),
      ],
    );
  }
}
