// class HotelOrder {
//   final int id;
//   final int user;
//   final Booking booking;
//   final DateTime orderDate;
//   final String status;
//   final double totalAmount;

//   HotelOrder({
//     required this.id,
//     required this.user,
//     required this.booking,
//     required this.orderDate,
//     required this.status,
//     required this.totalAmount,
//   });

//   factory HotelOrder.fromJson(Map<String, dynamic> json) {
//     return HotelOrder(
//       id: json['id'],
//       user: json['user'],
//       booking: Booking.fromJson(json['booking']),
//       orderDate: DateTime.parse(json['orderDate']),
//       status: json['status'],
//       totalAmount: double.parse(json['totalAmount']),
//     );
//   }
// }

// class Booking {
//   final int id;
//   final int user;
//   final int roomType;
//   final String checkInDate;
//   final String checkOutDate;
//   final String checkInTime;
//   final String checkOutTime;
//   final double totalAmount;
//   final int guest;
//   final int numberOfRooms;

//   Booking({
//     required this.id,
//     required this.user,
//     required this.roomType,
//     required this.checkInDate,
//     required this.checkOutDate,
//     required this.checkInTime,
//     required this.checkOutTime,
//     required this.totalAmount,
//     required this.guest,
//     required this.numberOfRooms,
//   });

//   factory Booking.fromJson(Map<String, dynamic> json) {
//     return Booking(
//       id: json['id'],
//       user: json['user'],
//       roomType: json['room_type'],
//       checkInDate: json['check_in_date'],
//       checkOutDate: json['check_out_date'],
//       checkInTime: json['check_in_time'],
//       checkOutTime: json['check_out_time'],
//       totalAmount: double.parse(json['total_amount']),
//       guest: json['guest'],
//       numberOfRooms: json['number_of_rooms'],
//     );
//   }
// }

class HotelOrder {
  final int id;
  final int user;
  final Booking booking;
  final DateTime orderDate;
  final String status;
  final double totalAmount;

  HotelOrder({
    required this.id,
    required this.user,
    required this.booking,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
  });

  factory HotelOrder.fromJson(Map<String, dynamic> json) {
    return HotelOrder(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      booking: Booking.fromJson(json['booking'] ?? {}),
      orderDate: DateTime.tryParse(json['orderDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      totalAmount: double.tryParse(json['totalAmount']?.toString() ?? '0') ?? 0.0,
    );
  }
}

class Booking {
  final int id;
  final int user;
  final int roomType;
  final String checkInDate;
  final String checkOutDate;
  final String checkInTime;
  final String checkOutTime;
  final double totalAmount;
  final int guest;
  final int numberOfRooms;

  Booking({
    required this.id,
    required this.user,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalAmount,
    required this.guest,
    required this.numberOfRooms,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      user: json['user'] ?? 0,
      roomType: json['room_type'] ?? 0,
      checkInDate: json['check_in_date'] ?? '',
      checkOutDate: json['check_out_date'] ?? '',
      checkInTime: json['check_in_time'] ?? '',
      checkOutTime: json['check_out_time'] ?? '',
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0,
      guest: json['guest'] ?? 0,
      numberOfRooms: json['number_of_rooms'] ?? 0,
    );
  }
}
