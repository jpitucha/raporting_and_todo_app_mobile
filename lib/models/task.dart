class Task {
  String id;
  String employee;
  String date;
  String content;

  Task(this.id, this.employee, this.date, this.content);

  String toString() {
    return '{ ${this.id}, ${this.employee}, ${this.date}, ${this.content} }';
  }
}