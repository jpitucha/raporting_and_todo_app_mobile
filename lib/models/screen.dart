class Screen {
  String id;
  String name;
  String owner;

  Screen({this.id, this.name, this.owner});

  Screen.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.owner = map['owner'];
  }
}