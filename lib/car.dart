class Car {
  final int id;
  final String name;
  final String make;
  final int year;
  final bool available;
  final String pricePerDay;
  final List<String> images;
  final int numberOfPassengers;
  final int numberOfDoors;
  final bool airConditioning;
  final String transmission;
  final String fuelType;
  final int maxPowerHp;
  final int topSpeedMph;

  Car({
    required this.id,
    required this.name,
    required this.make,
    required this.year,
    required this.available,
    required this.pricePerDay,
    required this.images,
    required this.numberOfPassengers,
    required this.numberOfDoors,
    required this.airConditioning,
    required this.transmission,
    required this.fuelType,
    required this.maxPowerHp,
    required this.topSpeedMph,
  });

  // A factory constructor to create a Car instance from JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['model']['name'],
      make: json['model']['make']['name'],
      year: json['year'],
      available: json['available'],
      pricePerDay: json['price_per_day'],
      images: List<String>.from(json['image'].map((img) => img['image'])),
      numberOfPassengers: json['number_of_passengers'],
      numberOfDoors: json['number_of_doors'],
      airConditioning: json['air_conditioning'],
      transmission: json['transmission'],
      fuelType: json['fuel_type'],
      maxPowerHp: json['max_power_hp'],
      topSpeedMph: json['top_speed_mph'],
    );
  }
}
