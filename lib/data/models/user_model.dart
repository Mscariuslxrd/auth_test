class UserModel {
  final String userId;
  final String email;

  UserModel({required this.userId, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as String,
      email: json['email'] as String? ?? '',
    );
  }
} 