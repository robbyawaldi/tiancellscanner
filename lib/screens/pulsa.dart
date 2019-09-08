import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as Prov;
import 'package:qr_utils/qr_utils.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/models/nominal.dart';
import 'package:tiancell/models/provider.dart';
import 'package:tiancell/models/transaction.dart';

import 'format.dart';

class PulsaCard extends StatefulWidget {
  const PulsaCard({Key key}) : super(key: key);

  @override
  _PulsaCardState createState() => _PulsaCardState();
}

class _PulsaCardState extends State<PulsaCard> {
  Provider _provider;
  Nominal _nominal;
  final _formKey = GlobalKey<FormState>();
  var numberField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cart = Prov.Provider.of<CartModel>(context);

    return SizedBox(
      height: _nominal != null ? 220 : 140,
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _nominal == null
                ? _selectPulsa()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Item name
                      Text(
                        "${_provider.name.toUpperCase()} ${_nominal.name.toUpperCase()}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: numberField,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Nomor',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            validator: (value) {
                              if (value.length > 15) {
                                return 'Panjang nomor melebihi 15 karakter';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
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
                          FlatButton.icon(
                            icon: Icon(Icons.add),
                            color: Colors.orange[600],
                            textColor: Colors.white,
                            label: Text('Tambah ke Keranjang'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                cart.addTransaction(
                                    _provider, _nominal, numberField.text);
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
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  )),
      ),
    );
  }

  Widget _selectPulsa() {
    return FutureBuilder<List<Provider>>(
      future: ProviderModel().providers(),
      builder: (BuildContext context, AsyncSnapshot<List<Provider>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Pulsa', style: Theme.of(context).textTheme.headline),
                FutureBuilder<Transaction>(
                  future: TransactionModel().latestTransaction(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Center();
                    return Text(
                      '${snapshot.data.number}',
                      style: TextStyle(color: Colors.grey),
                    );
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  hint: Text(_provider?.name ?? 'Provider'),
                ),
                DropdownButton<Nominal>(
                  items: _provider == null
                      ? []
                      : _provider.nominals
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
                  hint: Text('Nominal'),
                ),
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    await QrUtils.scanQR.then((id) {
                      if (id != null) {
                        NominalModel().getById(id).then((nominal) {
                          ProviderModel()
                              .getById(nominal.provider.toString())
                              .then((provider) {
                            setState(() {
                              _provider = provider;
                              _nominal = nominal;
                            });
                          });
                        });
                      }
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
}
