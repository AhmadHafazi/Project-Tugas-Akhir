

class User {
  final int? id;
  final String photo;
  final String fullName;
  final String nickname;
  final String phoneNumber;
  final String email;
  final String password;
  final String address;
  final String region;

  User({
    this.id,
    required this.photo,
    required this.fullName,
    required this.nickname,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
    required this.region,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'fullName': fullName,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'address': address,
      'region': region,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      photo: map['photo'],
      fullName: map['fullName'],
      nickname: map['nickname'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      password: map['password'],
      address: map['address'],
      region: map['region'],
    );
  }
}
