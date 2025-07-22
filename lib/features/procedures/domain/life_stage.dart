class LifeStage {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final int order;
  final int completedCount;
  final int totalCount;

  const LifeStage({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.order,
    this.completedCount = 0,
    this.totalCount = 0,
  });

  factory LifeStage.fromJson(Map<String, dynamic> json) {
    return LifeStage(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconName: json['icon_name'] as String,
      order: json['order'] as int,
      completedCount: json['completed_count'] as int? ?? 0,
      totalCount: json['total_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon_name': iconName,
      'order': order,
      'completed_count': completedCount,
      'total_count': totalCount,
    };
  }
}