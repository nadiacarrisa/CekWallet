import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'package:money_management/services/HistoryService.dart';
import 'package:money_management/services/LimitService.dart';
import 'Validator.dart';
import 'package:intl/intl.dart';
import 'models/History.dart';

class EditForm extends StatefulWidget {
  final History edit;
  EditForm(this.edit);

  @override
  _EditFormState createState() => _EditFormState(this.edit);
}

class _EditFormState extends State<EditForm> with Validation{
  LimitCon limitDb = LimitCon();
  HistoryCon historyDb = HistoryCon();
  History editState;
  _EditFormState(this.editState);

  TextEditingController deskController = TextEditingController();
  TextEditingController jumlahController = MoneyMaskedTextController(initialValue: 0,thousandSeparator: '', precision: 0,decimalSeparator: '');
  String dropdownJenis;
  String dropdownKategori;
  final formKey = GlobalKey<FormState>();
  List limit,total;
  String jumlah = '';
  DateTime dateTime = DateTime.now();
  String Formatter, FormatterMonthYear, monthYear;
  int Jmllimit, JmlExpense;
  bool viewVisible = false;

  void KeteranganExpense(String kategori, String tgl) async{
    limit = await LimitCon().checkLimit(kategori);
    limit.forEach(
          (jmlLimit) {
        setState(() {
          Jmllimit = jmlLimit['jumlah'];
          if(Jmllimit==null) Jmllimit=0;
        });
      },
    );
    total = await LimitCon().checkExpense(kategori, tgl);
    total.forEach(
          (jmlLimit) {
        setState(() {
          JmlExpense = jmlLimit['Total'];
          if(JmlExpense==null) JmlExpense=0;
          monthYear = tgl;
        });
      },
    );
  }

  void isLimited(History k) async{
    var jml,expense;
    limit = await LimitCon().checkLimit(k.kategori);
    limit.forEach(
          (jmlLimit) {
            jml = jmlLimit['jumlah'];
            if(jml==null) jml=0;
          },
    );
    total = await LimitCon().checkExpense(k.kategori, k.bulanTahun);
    total.forEach(
          (jmlLimit) {
            expense = jmlLimit['Total'];
            if(expense==null)
              expense=0;
          },
    );
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
                child: Text("Batal", style: TextStyle(color: Colors.red),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Lanjut"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context,k);
                },
              ),
            ],
          );
        },
      );
    }
    else{
      Navigator.pop(context,k);
    }
  }

  void deleteItem(History his){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("AWAS"),
          content: Text("Anda yakin akan menghapus item ini?"),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          actions: [
            FlatButton(
              child: Text("Batal", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Iya"),
              onPressed: () async {
                await historyDb.deleteHistory(his);
                Navigator.pop(context);
                Navigator.pop(context,his);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    KeteranganExpense(editState.kategori, editState.bulanTahun);
    deskController.text = editState.deskripsi;
    jumlahController.text = editState.jumlah.toString();
    Formatter= editState.date;
    FormatterMonthYear = editState.bulanTahun;
    if(editState.kategori == 'Pemasukan'){
      dropdownJenis = editState.kategori;
    }else{
      dropdownJenis = 'Pengeluaran';
      dropdownKategori = editState.kategori;
      viewVisible = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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
                      Formatter,
                      style: TextStyle(fontSize: 25,)
                  ),
                  onTap: (){
                    showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime.now()).then((date){
                      if(date!=null){
                        setState(() {
                          Formatter = DateFormat('dd MMMM yyyy').format(date).toString();
                          FormatterMonthYear = DateFormat('MMMM yyyy').format(date);
                          KeteranganExpense(dropdownKategori, DateFormat('MMMM yyyy').format(date));
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
                    Container(
                      child: Row(
                        children: <Widget>[
                          DropdownButton(
                            value: dropdownJenis,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue){
                              setState(() {
                                dropdownJenis = newValue;
                                if(dropdownJenis=='Pengeluaran'){
                                  viewVisible = true;
                                }else if(dropdownJenis=='Pemasukan'){
                                  viewVisible = false;
                                }
                              });
                            },
                            items: <String>['Pemasukan','Pengeluaran']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                                .toList(),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: viewVisible,
                            child: DropdownButton(
                              value: dropdownKategori,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              onChanged: (String newValue){
                                setState(() {
                                  dropdownKategori = newValue;
                                  KeteranganExpense(dropdownKategori, editState.bulanTahun);
                                  print(editState.bulanTahun);
                                });
                              },
                              items: <String>['Makanan','Hiburan','Belanja']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: viewVisible,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              title: Text('Limit : Rp $Jmllimit',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text('Pengeluaran Bulan $monthYear : Rp $JmlExpense',
                                style: TextStyle(fontSize: 15),
                              ),
                          ),
                        ],
                      ),
                    ),
                    Padding (
                      padding: EdgeInsets.only(top:10.0, bottom:15.0),
                      child: TextFormField(
                        controller: deskController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
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
                      padding: EdgeInsets.only(top:10.0),
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
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: viewVisible,
                      child: ListTile(
                          title: Text('AWAS, hemat!!! Pengeluaran harus 75% kurang dari limit!!!',
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
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
                                  if(Jmllimit==null){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("PERHATIAN"),
                                          content: Text("Silahkan pilih kategroi yang akan dipilih!!!"),
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                                          actions: [
                                            FlatButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else{
                                    if(formKey.currentState.validate()){
                                    formKey.currentState.save();
                                    editState.deskripsi = deskController.text;
                                    editState.jumlah = int.parse(jumlahController.text);
                                    editState.date = Formatter;
                                    editState.kategori = dropdownJenis == 'Pemasukan'? dropdownJenis : dropdownKategori;
                                    editState.tag = dropdownJenis == 'Pemasukan'? '+' : '-';
                                    editState.bulanTahun = FormatterMonthYear;
                                    if(dropdownJenis == 'Pemasukan'){
                                    Navigator.pop(context,editState);
                                    }else{
                                    this.isLimited(editState);
                                    }
                                    }
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
                    Padding (
                      padding: EdgeInsets.only(top:10.0, bottom:15.0),
                      child: Row(
                        children: <Widget> [
                          // tombol delete
                          Expanded(
                            child: Material(
                              elevation: 1.0,
                              borderRadius: BorderRadius.circular(100.0),
                              color: Color.fromRGBO(0, 149, 218, 1),
                              child: MaterialButton(
                                onPressed: () {
                                  deleteItem(editState);
                                },
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                                child: Text('HAPUS',
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