class Medicine {
  final int id;
  final String name;
  final String dosage;
  final String form;
  final String manufacturer;
  final String description;
  final String imageUrl;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.form,
    required this.manufacturer,
    required this.description,
    required this.imageUrl,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      form: json['form'],
      manufacturer: json['manufacturer'],
      description: json['description'],
      imageUrl: json["imageUrl"] ?? "", // Ảnh mặc định nếu null
    );
  }
}
