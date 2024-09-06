class SignupUser {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String accountNumber;
  // final String photo;
  // final String phone_number;

  SignupUser({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.accountNumber,
    // required this.photo,
    // required this.phone_number,
    
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accountNumber: json['account_number'],
      // photo: json['photo'] ?? '',
      // phone_number: json['phone_number']  ?? '' ,
      
    );
  }
}
