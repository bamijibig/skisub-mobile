class Transaction {
  final int id;
  final String accountNumber;
  final String settlementId;
  final String sessionId;
  final String tranRemarks;
  final double transactionAmount;
  final double settledAmount;
  final double feeAmount;
  final double vatAmount;
  final String currency;
  final String initiationTranRef;
  final String sourceAccountNumber;
  final String sourceAccountName;
  final String sourceBankName;
  final String channelId;
  final DateTime tranDateTime;

  Transaction({
    required this.id,
    required this.accountNumber,
    required this.settlementId,
    required this.sessionId,
    required this.tranRemarks,
    required this.transactionAmount,
    required this.settledAmount,
    required this.feeAmount,
    required this.vatAmount,
    required this.currency,
    required this.initiationTranRef,
    required this.sourceAccountNumber,
    required this.sourceAccountName,
    required this.sourceBankName,
    required this.channelId,
    required this.tranDateTime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountNumber: json['accountNumber'],
      settlementId: json['settlementId'],
      sessionId: json['sessionId'],
      tranRemarks: json['tranRemarks'],
      transactionAmount: double.parse(json['transactionAmount']),
      settledAmount: double.parse(json['settledAmount']),
      feeAmount: double.parse(json['feeAmount']),
      vatAmount: double.parse(json['vatAmount']),
      currency: json['currency'],
      initiationTranRef: json['initiationTranRef'],
      sourceAccountNumber: json['sourceAccountNumber'],
      sourceAccountName: json['sourceAccountName'],
      sourceBankName: json['sourceBankName'],
      channelId: json['channelId'],
      tranDateTime: DateTime.parse(json['tranDateTime']),
    );
  }
}

class SignupUser {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String accountNumber;

  SignupUser({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.accountNumber,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      accountNumber: json['account_number'],
    );
  }
}
List<Transaction> filterTransactionsByAccount(List<Transaction> transactions, String accountNumber) {
  return transactions.where((transaction) => transaction.accountNumber == accountNumber).toList();
}
