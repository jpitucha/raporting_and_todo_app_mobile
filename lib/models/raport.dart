class Raport {
  String id;
  String user;
  String date;
  String content;

  Raport(this.id, this.user, this.date, this.content);

  String toString() {
    return '{ ${this.id}, ${this.user}, ${this.date}, ${this.content} }';
  }
}
