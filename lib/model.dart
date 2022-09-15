class User {
  final String name;
  final String age;
  final String notes;

  User({required this.name, required this.age, required this.notes});
  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'notes': notes};
  }

  static User fromJson(Map<String, dynamic> json) =>
      User(name: json['name'], age: json['age'], notes: json['notes']);
}
