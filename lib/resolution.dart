class Resolution {
  String name;
  int year;
  bool done;
  DateTime finishDate;
  List<String> tags;
  String type;
  int count;
  int target;

  Resolution(this.name);

  Resolution.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        done = json['done'],
        finishDate = json['finishDate'],
        // tags = json['tags'],
        type = json['type'],
        count = json['count'],
        target = json['target'];

  @override
  String toString() {
    return '$name';
  }
}
