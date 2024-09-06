// class CarOrder {
//   final int id;
//   final int user;
//   final CarBooking booking;
//   final DateTime orderDate;
//   final String status;
//   final double totalAmount;

//   CarOrder({
//     required this.id,
//     required this.user,
//     required this.booking,
//     required this.orderDate,
//     required this.status,
//     required this.totalAmount,
//   });

//   factory CarOrder.fromJson(Map<String, dynamic> json) {
//     return CarOrder(
//       id: json['id'],
//       user: json['user'],
//       booking: CarBooking.fromJson(json['booking']),
//       orderDate: DateTime.parse(json['orderDate']),
//       status: json['status'],
//       totalAmount: double.parse(json['totalAmount']),
//     );
//   }
// }

// class CarBooking {
//   final int id;
//   final int user;
//   final int car;
//   final String startDate;
//   final String endDate;
//   final String pickupTime;
//   final String dropoffTime;
//   final int age;
//   final bool isApproved;
//   final double totalAmount;
//   final String pickupLocation;
//   final String dropoffLocation;

//   CarBooking({
//     required this.id,
//     required this.user,
//     required this.car,
//     required this.startDate,
//     required this.endDate,
//     required this.pickupTime,
//     required this.dropoffTime,
//     required this.age,
//     required this.isApproved,
//     required this.totalAmount,
//     required this.pickupLocation,
//     required this.dropoffLocation,
//   });

//   factory CarBooking.fromJson(Map<String, dynamic> json) {
//     return CarBooking(
//       id: json['id'],
//       user: json['user'],
//       car: json['car'],
//       startDate: json['start_date'],
//       endDate: json['end_date'],
//       pickupTime: json['pickup_time'],
//       dropoffTime: json['dropoff_time'],
//       age: json['age'],
//       isApproved: json['is_approved'],
//       totalAmount: double.parse(json['total_amount']),
//       pickupLocation: json['pickup_location'],
//       dropoffLocation: json['dropoff_location'],
//     );
//   }
// }

class CarOrder {
  final int id;
  final int user;
  final CarBooking booking;
  final DateTime orderDate;
  final String status;
  final double totalAmount;

  CarOrder({
    required this.id,
    required this.user,
    required this.booking,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
  });

  factory CarOrder.fromJson(Map<String, dynamic> json) {
    return CarOrder(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      booking: CarBooking.fromJson(json['booking'] ?? {}),
      orderDate: DateTime.tryParse(json['orderDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      totalAmount: double.tryParse(json['totalAmount']?.toString() ?? '0') ?? 0.0,
    );
  }
}

class CarBooking {
  final int id;
  final int user;
  final int car;
  final String startDate;
  final String endDate;
  final String pickupTime;
  final String dropoffTime;
  final int age;
  final bool isApproved;
  final double totalAmount;
  final String pickupLocation;
  final String dropoffLocation;

  CarBooking({
    required this.id,
    required this.user,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.pickupTime,
    required this.dropoffTime,
    required this.age,
    required this.isApproved,
    required this.totalAmount,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  factory CarBooking.fromJson(Map<String, dynamic> json) {
    return CarBooking(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      car: json['car'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      pickupTime: json['pickup_time'] ?? '',
      dropoffTime: json['dropoff_time'] ?? '',
      age: json['age'] ?? 0,
      isApproved: json['is_approved'] ?? false,
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0,
      pickupLocation: json['pickup_location'] ?? '',
      dropoffLocation: json['dropoff_location'] ?? '',
    );
  }
}
