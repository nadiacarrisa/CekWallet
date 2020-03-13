class Kategori {
  int _id;
  String _kategori;
  int _jumlah;
  String _tag;
  String _tanggal;
  String _deskripsi;
  String bulanTahun;

  // konstruktor versi 1
  Kategori.withMontYear(this._kategori, this._jumlah, this._tanggal, this._deskripsi, this._tag, this.bulanTahun);
  Kategori(this._kategori, this._jumlah, this._tanggal, this._deskripsi, this._tag);
  Kategori.withID(this._id, this._kategori, this._jumlah, this._tanggal, this._deskripsi, this._tag);

  // konstruktor versi 2: konversi dari Map ke Contact
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kategori = map['kategori'];
    this._jumlah = map['jumlah'];
    this._tanggal = map['tanggal'];
    this._deskripsi = map['deskripsi'];
    this._tag = map['tag'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kategori'] = this._kategori;
    map['jumlah'] = this._jumlah;
    map['tanggal'] = this._tanggal;
    map['deskripsi'] = this._deskripsi;
    map['tag'] = this._tag;
    return map;
  }

  // getter
  int get id => _id;
  String get kategori => _kategori;
  int get jumlah => _jumlah;
  String get tanggal => _tanggal;
  String get deskripsi => _deskripsi;
  String get tag => _tag;

  // setter
  set kategori(String value) {
    _kategori = value;
  }

  set jumlah(int value) {
    _jumlah = value;
  }

  set tanggal(String value) {
    _tanggal = value;
  }

  set deskripsi(String value) {
    _deskripsi = value;
  }

  set tag(String value) {
    _tag = value;
  }

}