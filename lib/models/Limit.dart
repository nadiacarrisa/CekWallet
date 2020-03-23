class Limit {
//      'CREATE TABLE history ( id INTEGER PRIMARY KEY AUTOINCREMENT, kategori TEXT, jumlah INTEGER, date TEXT, deskripsi TEXT, tag TEXT);'
  int id;
  String kategori;
  int jumlah;

  Limit({this.id, this.kategori, this.jumlah});

  Limit.fromMap(Map<String, dynamic> historyMaps) {
    this.id = historyMaps['id'];
    this.kategori = historyMaps['kategori'];
    this.jumlah = historyMaps['jumlah'];
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
      'jumlah': jumlah,
    };
  }
}