// user_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/trans_signup.dart'; // Adjust the import path as needed

class UserService {
  final Dio dio = Dio();

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<SignupUser?> fetchSignupUser() async {
    const String signupUrl = 'http://skis.eu-west-1.elasticbeanstalk.com/account/signup/';

    try {
      final String? token = await _getAuthToken();
      if (token == null) return null;

      final response = await dio.get(
        signupUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        }),
      );

      if (response.statusCode == 200) {
        final userData = response.data[0]; // Assuming the first item is the user
        return SignupUser.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Transaction>> fetchTransactions() async {
    const String transactionsUrl = 'http://skis.eu-west-1.elasticbeanstalk.com/account/transaction';

    try {
      final String? token = await _getAuthToken();
      if (token == null) return [];

      final response = await dio.get(
        transactionsUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> transactionList = response.data;
        return transactionList.map((json) => Transaction.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
