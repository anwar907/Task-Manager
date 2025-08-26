class TaskModel {
  final String? id;
  final String title;
  final String description;
  final bool? isCompleted;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final String dueDate;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted,
    this.userId,
    this.createdAt,
    this.updatedAt,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      dueDate: json['due_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'due_date': dueDate,
    };
  }
}
