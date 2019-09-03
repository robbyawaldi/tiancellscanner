import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as Prov;
import 'package:qr_utils/qr_utils.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/models/nominal.dart';
import 'package:tiancell/models/provider.dart';

import 'format.dart';

class PulsaCard extends StatefulWidget {
  const PulsaCard({Key key}) : super(key: key);

  @override
  _PulsaCardState createState() => _PulsaCardState();
}

class _PulsaCardState extends State<PulsaCard> {
  Provider _provider;
  Nominal _nominal;

  @override
  Widget build(BuildContext context) {
    var cart = Prov.Provider.of<CartModel>(context);

    return Container(
      height: _nominal != null ? 210 : 100,
      width: 279,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _nominal != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Item name
                    Text(
                      "${_provider.name.toUpperCase()} ${_nominal.name.toUpperCase()}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // Item price
                    Text(
                      '${rupiah(_nominal.price).formattedLeftSymbol}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // Cancel button
                        SizedBox(
                          width: 70,
                          child: FlatButton(
                            child: Text('Batal'),
                            onPressed: () {
                              setState(() {
                                _provider = null;
                                _nominal = null;
                              });
                            },
                          ),
                        ),
                        // Add button
                        FlatButton(
                          color: Colors.orange[600],
                          textColor: Colors.white,
                          child: Text('Tambah ke Keranjang'),
                          onPressed: () {
                            cart.addTransaction(_provider, _nominal);
                            setState(() {
                              _provider = null;
                              _nominal = null;
                            });
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Transaksi pulsa berhasil ditambahkan ke keranjang'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                )
              : _selectPulsa(),
        ),
      ),
    );
  }

  Widget _selectPulsa() {
    return FutureBuilder<List<Provider>>(
      future: ProviderModel().providers(),
      builder: (BuildContext context, AsyncSnapshot<List<Provider>> snapshot) {
        if (!snapshot.hasData) return Center(child: Text('Loading..'));
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                DropdownButton<Provider>(
                  items: snapshot.data
                      .map((provider) => DropdownMenuItem<Provider>(
                            child: Text(provider.name),
                            value: provider,
                          ))
                      .toList(),
                  onChanged: (Provider provider) {
                    setState(() {
                      _provider = provider;
                    });
                  },
                  hint: Text('Pilih Provider'),
                ),
                DropdownButton<Nominal>(
                  items: _provider?.nominals ?? []
                      .map((nominal) => DropdownMenuItem<Nominal>(
                            child: Text(nominal.name),
                            value: nominal,
                          ))
                      .toList(),
                  onChanged: (Nominal nominal) {
                    setState(() {
                      _nominal = nominal;
                    });
                  },
                  hint: Text('Pilih Nominal'),
                ),

              ],
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () async {
                await QrUtils.scanQR.then((id) {
                  NominalModel()
                      .getById(id)
                      .then((nominal) => setState(() => _nominal = nominal));
                });
              },
            )
          ],
        );
      },
    );
  }
}
