class Pack {
  String sender;
  DateTime date;
  String status;

  Pack(this.sender, this.date, this.status);

  @override
  String toString() {
    return '{ ${this.sender}, ${this.date.toString().split(" ").elementAt(0)}, ${this.status} }';
  }
}