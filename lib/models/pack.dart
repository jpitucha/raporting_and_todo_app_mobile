class Pack {
  String sender;
  DateTime date;
  String status;

  Pack(this.sender, this.date, this.status);

  @override
  String toString() {
    return '{ ${this.sender}, ${this.date.toString().split(" ").elementAt(0)}, ${this.status} }';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['sender'] = sender;
    map['date'] = date;
    map['status'] = status;
    return map;
  }

  Pack.fromMap(Map<String, dynamic> map) {
    this.sender = map['sender'];
    this.date = map['date'];
    this.status = map['status'];
  }
}