import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:tiancell/models/Auth.dart';
import 'package:tiancell/models/service.dart';
import 'package:http/http.dart' as http;

class FormService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Form Service'),
      ),
      body: SingleChildScrollView(child: ServiceForm()),
    );
  }
}

class ServiceForm extends StatefulWidget {
  ServiceForm({Key key}) : super(key: key);

  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();
  var merkField = TextEditingController();
  var tipeField = TextEditingController();
  var deskField = TextEditingController();
  var modalField = MoneyMaskedTextController(
      leftSymbol: 'Harga Modal: Rp',
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);
  var jualField = MoneyMaskedTextController(
      leftSymbol: 'Harga Jual: Rp',
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  Future<int> post(Service service) async {
    var response = await http.post('http://192.168.1.6/api/services/services/',
        headers: {'Authorization': basicAuth}, body: service.toJson());
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: merkField,
              decoration: InputDecoration(
                  hintText: 'Merk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.indigo))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tolong masukkan form merk';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: tipeField,
              decoration: InputDecoration(
                  hintText: 'Tipe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.indigo))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tolong masukkan form tipe';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: deskField,
              decoration: InputDecoration(
                  hintText: 'Keterangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.indigo))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tolong masukkan form keterangan';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: modalField,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Harga Modal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.indigo))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tolong masukkan form harga modal';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: jualField,
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Harga Jual',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.indigo))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Tolong masukkan form harga jual';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Colors.orange[600],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Service service = Service.input(
                          brand: merkField.text,
                          type: tipeField.text,
                          desc: deskField.text,
                          cost: modalField.numberValue,
                          price: jualField.numberValue);
                      post(service).then((response) {
                        if (response == 201) {
                          merkField.clear();
                          tipeField.clear();
                          deskField.clear();
                          modalField.clear();
                          jualField.clear();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Data berhasil disimpan!😆"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Tutup"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    }
                  },
                  child: Text('Kirim'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
