class Task {
  String id;
  String user;
  String date;
  String content;
  String timeStamp;

  Task({this.id, this.user, this.date, this.content, this.timeStamp});

  String toString() {
    return '{ ${this.id}, ${this.user}, ${this.date}, ${this.content}, ${this.timeStamp} }';
  }
}