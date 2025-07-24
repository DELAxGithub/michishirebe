import 'procedure.dart';

class Task {
  final String id;
  final int procedureId;
  final String sessionId;
  final String status;
  final String? notes;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  // 関連する手続き情報（JOINで取得）
  final Procedure? procedure;

  Task({
    required this.id,
    required this.procedureId,
    required this.sessionId,
    required this.status,
    this.notes,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.procedure,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      procedureId: json['procedure_id'] as int,
      sessionId: json['session_id'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      procedure: json['procedures'] != null
          ? Procedure.fromJson(json['procedures'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'procedure_id': procedureId,
      'session_id': sessionId,
      'status': status,
      'notes': notes,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Task copyWith({
    String? status,
    String? notes,
    DateTime? completedAt,
  }) {
    return Task(
      id: id,
      procedureId: procedureId,
      sessionId: sessionId,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      procedure: procedure,
    );
  }
}