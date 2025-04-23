class MuscleGroup {
  final String id;
  final String name;

  MuscleGroup({
    required this.id,
    required this.name,
  });

  factory MuscleGroup.fromJson(Map<String, dynamic> json) {
    return MuscleGroup(
      id: json['id'],
      name: json['name'],
    );
  }
}
