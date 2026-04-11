class UserModel {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String role;
  final String businessName;
  final String businessDetail;
  final String state;
  final String city;
  final String locality;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
    required this.businessName,
    required this.businessDetail,
    required this.state,
    required this.city,
    required this.locality,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      businessName: json['businessName'] ?? '',
      businessDetail: json['businessDetail'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      locality: json['locality'] ?? '',
    );
  }
}