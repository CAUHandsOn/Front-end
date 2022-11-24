class ClassEntity{
  late String id;
  late String name;

  ClassEntity({
    required this.id,
    required this.name
  });

  ClassEntity.fromMap(Map<String, dynamic>? map) {
    id = map?['id'] ?? '';
    name = map?['name'] ?? '';
  }
}