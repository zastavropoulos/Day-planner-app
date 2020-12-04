class Task {
  final String name;
  final String description;

  Task(this.name, this.description);

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
