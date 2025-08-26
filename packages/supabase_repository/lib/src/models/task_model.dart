class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String? userId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.dueDate,
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
      deletedAt: json['deleted_at'],
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
      'deleted_at': deletedAt,
      'due_date': dueDate,
    };
  }
}
