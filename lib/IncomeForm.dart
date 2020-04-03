import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'package:money_management/models/History.dart';
import 'Validator.dart';
import 'models/History.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  final History pemasukan;
  IncomeForm(this.pemasukan);

  @override
  _IncomeFormState createState() => _IncomeFormState(this.pemasukan);
}

class _IncomeFormState extends State<IncomeForm> with Validation{
  History pemasukanState;
  _IncomeFormState(this.pemasukanState);

  TextEditingController deskController = TextEditingController();
  TextEditingController jumlahController = MoneyMaskedTextController(initialValue: 0,thousandSeparator: '',precision: 0, decimalSeparator: '');

  final formKey = GlobalKey<FormState>();
  String jumlah = '';
  DateTime dateTime= DateTime.now();

  @override
  Widget build(BuildContext context) {

    if (pemasukanState != null) {
      deskController.text = pemasukanState.deskripsi;
      jumlahController.text = pemasukanState.jumlah.toString();
      dateTime =  DateTime.parse(pemasukanState.date);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Pemasukan'),
          backgroundColor: Color.fromRGBO(0, 149, 218, 1),
        ),
        body: ListView(
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0,top: 10),
              child: Container(
                width: double.infinity,
                height: 75.0,
                child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Tanggal', style: TextStyle(fontSize: 15,)),
                    subtitle: Text(
                        DateFormat('dd MMMM yyyy').format(dateTime).toString(),
                        style: TextStyle(fontSize: 25,)
                    ),
                    onTap: (){
                      showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime.now()).then((date){
                        if(date!=null){
                          setState(() {
                            dateTime = date;
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding (
                        padding: EdgeInsets.only(top:20.0, bottom:15.0),
                        child: TextFormField(
                          controller: deskController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Nama Pemasukan',
                            icon: Icon(Icons.mode_edit),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          validator: validateName,
                          onSaved: (String value) { //KETIKA LOLOS VALIDASI

                          },
                        ),
                      ),

                      Padding (
                        padding: EdgeInsets.only(top:15.0, bottom:15.0),
                        child: TextFormField(
                          controller: jumlahController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Jumlah',
                            icon: Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          validator: validateValue,
                          onSaved: (String value) { //KETIKA LOLOS VALIDASI
                            jumlah = value;
                          },
                        ),
                      ),

                      // tombol button
                      Padding (
                        padding: EdgeInsets.only(top:15.0, bottom:15.0),
                        child: Row(
                          children: <Widget> [
                            // tombol simpan
                            Expanded(
                              child: Material(
                                elevation: 1.0,
                                borderRadius: BorderRadius.circular(100.0),
                                color: Color.fromRGBO(232, 108, 0, 1),
                                child: MaterialButton(
                                  onPressed: () {
                                    if(formKey.currentState.validate()){
                                      formKey.currentState.save();
                                      if (pemasukanState == null) {
                                        pemasukanState = History.withMontYear('Pemasukan',
                                            int.parse(jumlahController.text.toString()),
                                            DateFormat('dd MMMM yyyy').format(dateTime).toString(),
                                            deskController.text, '+',
                                            DateFormat('MMMM yyyy').format(dateTime).toString()
                                        );
                                      } else {
                                        pemasukanState.deskripsi = deskController.text;
                                        pemasukanState.jumlah = int.parse(jumlahController.text);
                                        pemasukanState.date = DateFormat("dd MMMMM yyyy").format(dateTime).toString();
                                      }
                                      Navigator.pop(context, pemasukanState);
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                                  child: Text('SIMPAN',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}