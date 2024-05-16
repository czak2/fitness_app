class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;

  const UserModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['userId'],
        name: json['name'],
        image: json['imageUrl'],
        email: json['emailId'],
      );

  Map<String, dynamic> toJson() => {
        'userId': uid,
        'name': name,
        'imageUrl': image,
        'emailId': email,
      };
}
