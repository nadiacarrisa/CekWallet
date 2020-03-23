import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'package:money_management/services/LimitService.dart';
import 'package:moneytextformfield/moneytextformfield.dart';
import 'Validator.dart';
import 'package:intl/intl.dart';
import 'models/History.dart';
import 'services/DBlite.dart';

class ExpenseForm extends StatefulWidget {
  final String jenis;
  final History pengeluaran;
  ExpenseForm(this.jenis, this.pengeluaran);

  @override
  _ExpenseFormState createState() => _ExpenseFormState(this.pengeluaran, this.jenis);
}

class _ExpenseFormState extends State<ExpenseForm> with Validation{
  LimitCon limitDb = LimitCon();
  History pengeluaranState;
  String jenisState;
  _ExpenseFormState(this.pengeluaranState, this.jenisState);

  TextEditingController deskController = TextEditingController();
  TextEditingController jumlahController = MoneyMaskedTextController(initialValue: 0,thousandSeparator: '', precision: 0,decimalSeparator: '');

  final formKey = GlobalKey<FormState>();
  List limit,total;
  String jumlah = '';
  DateTime dateTime = DateTime.now();


  void isLimited(History k) async{
    var jml,expense;
    limit = await LimitCon().checkLimit(k);
    limit.forEach(
          (jmlLimit) {
            jml = jmlLimit['jumlah'];
          },
    );
    total = await LimitCon().checkExpense(k);
    total.forEach(
          (jmlLimit) {
            expense = jmlLimit['Total'];
          },
    );
    String formatter = DateFormat("MM yyyy").format(DateTime.now()).toString();
    if(jml!=null && formatter == k.bulanTahun){
      if(k.jumlah + expense > 0.75 * jml){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("AWAS"),
              content: Text("Melebihi PENGELUARAN Anda Bulan ini!!!"),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
              actions: [
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                         Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
    else{
      Navigator.pop(context,k);
    }
  }

  @override
  Widget build(BuildContext context) {

    if (pengeluaranState != null) {
      deskController.text = pengeluaranState.deskripsi;
      jumlahController.text = pengeluaranState.jumlah.toString();
      dateTime = DateTime.parse(pengeluaranState.date);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengeluaran'),
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
                    showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2019), lastDate: DateTime(2021)).then((date){
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
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ListTile(
                        title: Text('${widget.jenis}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Padding (
                      padding: EdgeInsets.only(top:10.0, bottom:15.0),
                      child: TextFormField(
                        controller: deskController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Pengeluaran',
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
                      padding: EdgeInsets.only(top:10.0, bottom:15.0),
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
                      padding: EdgeInsets.only(top:10.0, bottom:15.0),
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
                                    if (pengeluaranState == null) {
                                      pengeluaranState = History.withMontYear('${widget.jenis}',
                                          int.parse(jumlahController.text),
                                          DateFormat('dd MMMM yyyy').format(dateTime).toString(),
                                          deskController.text, '-',
                                          DateFormat('MM yyyy').format(dateTime).toString()
                                      );
                                    } else {
                                      pengeluaranState.deskripsi = deskController.text;
                                      pengeluaranState.jumlah = int.parse(jumlahController.text);
                                      pengeluaranState.date = DateFormat('dd MMMM yyyy').format(dateTime).toString();
                                    }
                                    this.isLimited(pengeluaranState);
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