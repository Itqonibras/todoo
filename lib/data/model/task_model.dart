class Task {
  late int? id;
  late String title;
  late String description;
  late int icon;
  late String date;
  late int isDone;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.date,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'date' : date,
      'isDone' : isDone,
    };
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    icon = map['icon'];
    date = map['date'];
    isDone = map['isDone'];
  }
}
