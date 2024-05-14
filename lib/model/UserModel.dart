// ignore_for_file: file_names

class UserModel {
  final String name;
  final String email;
  final String password;
  final String? id;
  final String? profilePicture;
  final String? token;
  final String? dateCreated;
  UserModel({
    required this.token,
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.profilePicture,
    required this.dateCreated,
  });
}
