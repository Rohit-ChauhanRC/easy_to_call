class Contact {
  final String name;
  final String phone;
  final String profilePhoto;

  Contact(
      {required this.name, required this.phone, required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'profilePhoto': profilePhoto,
      };

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phone: json['phone'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
