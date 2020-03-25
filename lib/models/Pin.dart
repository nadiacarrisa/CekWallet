class Pin{
  int id;
  String pin;

  Pin({this.id, this.pin});
  Pin.withoutID({this.pin});

  Pin.fromMap(Map<String, dynamic> pinMaps) {
    this.id = pinMaps['id'];
    this.pin = pinMaps['pin'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pin': pin,
    };
  }
}