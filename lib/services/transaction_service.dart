import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skisubapp/model/carorder.dart';
import 'package:skisubapp/model/hotelorder.dart';
import 'package:skisubapp/model/signup_user.dart';
import 'package:skisubapp/model/transaction.dart';

class TransactionService {
  final Dio _dio = Dio();
  final String signupApiUrl =
      'https://jpowered.pythonanywhere.com/account/userdetail/';
  final String transactionApiUrl =
      'https://jpowered.pythonanywhere.com/account/combinedorder/';

  Future<SignupUser?> fetchUserDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        print('User is not authenticated.');
        return null;
      }

      final formattedToken = 'Token $token';
      final response = await _dio.get(signupApiUrl,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': formattedToken,
          }));

      if (response.statusCode == 200) {
        return SignupUser.fromJson(response.data);
      } else {
        print(
            'Failed to fetch user details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
    return null;
  }

  Future<List<dynamic>> fetchAllTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        print('User is not authenticated.');
        return [];
      }

      final formattedToken = 'Token $token';
      final response = await _dio.get(transactionApiUrl,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': formattedToken,
          }));

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        List<dynamic> transactions = [];

        // Parse each type of order from the map
        if (data.containsKey('car_orders')) {
          transactions.addAll(
            (data['car_orders'] as List).map((item) => CarOrder.fromJson(item)),
          );
        }
        if (data.containsKey('hotel_orders')) {
          transactions.addAll(
            (data['hotel_orders'] as List).map((item) => HotelOrder.fromJson(item)),
          );
        }
        if (data.containsKey('transactions')) {
          transactions.addAll(
            (data['transactions'] as List).map((item) => Transaction.fromJson(item)),
          );
        }

        return transactions;
      } else {
        print('Failed to fetch transactions. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
    return [];
  }
}
