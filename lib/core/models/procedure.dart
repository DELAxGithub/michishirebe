class Procedure {
  final int id;
  final String lifeStage;
  final String category;
  final String name;
  final String priority;
  final String? defaultDeadline;
  final List<String> requiredDocuments;
  final String? responsibleOffice;
  final String reason;
  final String? hint;
  final int orderIndex;
  final DateTime createdAt;
  final DateTime updatedAt;

  Procedure({
    required this.id,
    required this.lifeStage,
    required this.category,
    required this.name,
    required this.priority,
    this.defaultDeadline,
    required this.requiredDocuments,
    this.responsibleOffice,
    required this.reason,
    this.hint,
    required this.orderIndex,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) {
    return Procedure(
      id: json['id'] as int,
      lifeStage: json['life_stage'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      priority: json['priority'] as String,
      defaultDeadline: json['default_deadline'] as String?,
      requiredDocuments: (json['required_documents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      responsibleOffice: json['responsible_office'] as String?,
      reason: json['reason'] as String,
      hint: json['hint'] as String?,
      orderIndex: json['order_index'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'life_stage': lifeStage,
      'category': category,
      'name': name,
      'priority': priority,
      'default_deadline': defaultDeadline,
      'required_documents': requiredDocuments,
      'responsible_office': responsibleOffice,
      'reason': reason,
      'hint': hint,
      'order_index': orderIndex,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}