class Raport {
  String id;
  String employee;
  String date;
  String content;

  Raport(this.id, this.employee, this.date, this.content);

  String toString() {
    return '{ ${this.id}, ${this.employee}, ${this.date}, ${this.content} }';
  }
}