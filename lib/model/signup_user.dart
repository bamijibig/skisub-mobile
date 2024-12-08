


class SignupUser {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String accountNumber;
  final String phoneNumber;
  final String? photo;
  final String? photoUrl;

  SignupUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accountNumber,
    required this.phoneNumber,
    this.photo,
    this.photoUrl,
  });

  // Factory constructor to parse JSON response
  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accountNumber: json['account_number'],
      phoneNumber: json['phone_number'],
      photo: json['photo'],  // This could be null, so nullable
      photoUrl: json['photo_url'], // This could be null, so nullable
    );
  }
}
