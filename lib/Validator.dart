
class Validation {
  String validateValue(String value) {
    if (int.parse(value) < 1000) { //JIKA VALUE KOSONG
      return 'Minimal Rp 1000'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) { //JIKA VALUE KOSONG
      return 'Harus Diisi'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }
}