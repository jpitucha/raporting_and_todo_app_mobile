class Pack {
  String title;
  String status;

  Pack(this.title, this.status);

  @override
  String toString() {
    return '{ ${this.title}, ${this.status} }';
  }
}