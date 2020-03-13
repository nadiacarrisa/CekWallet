class History {
//      'CREATE TABLE history ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER, date TEXT, deskripsi TEXT, tag TEXT);'
  int id;
  String kategori;
  int jumlah;
  String date;
  String deskripsi;
  String tag;

  History({this.id, this.kategori, this.jumlah, this.date, this.deskripsi, this.tag});

  History.fromMap(Map<String, dynamic> historyMaps) {
    this.id = historyMaps['id'];
    this.kategori = historyMaps['kategori'];
    this.jumlah = historyMaps['jumlah'];
    this.date = historyMaps['date'];
    this.deskripsi = historyMaps['deskripsi'];
    this.tag = historyMaps['tag'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
      'jumlah': jumlah,
      'date': date,
      'deskripsi': deskripsi,
      'tag': tag,
    };
  }
}