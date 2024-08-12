class Hotel {
  final int id;
  final String name;
  final String description;
  final String location;
  final List<Amenity> amenities;
  final List<HotelImage> images;
  final List<RoomType> roomTypes;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.amenities,
    required this.images,
    required this.roomTypes,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? 'No Description',
      location: json['location'] ?? 'No Location',
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((amenityJson) => Amenity.fromJson(amenityJson))
              .toList() ??
          [],
      images: (json['images'] as List<dynamic>?)
              ?.map((imageJson) => HotelImage.fromJson(imageJson))
              .toList() ??
          [],
      roomTypes: (json['room_types'] as List<dynamic>?)
              ?.map((roomTypeJson) => RoomType.fromJson(roomTypeJson))
              .toList() ??
          [],
    );
  }
}

class Amenity {
  final int id;
  final String name;

  Amenity({
    required this.id,
    required this.name,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
    );
  }
}

class HotelImage {
  final int id;
  final String image;

  HotelImage({
    required this.id,
    required this.image,
  });

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}

class RoomType {
  final int id;
  final String name;
  final double pricePerDay;
  final bool available;
  final int hotelId;

  RoomType({
    required this.id,
    required this.name,
    required this.pricePerDay,
    required this.available,
    required this.hotelId,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      pricePerDay: double.tryParse(json['price_per_day'] ?? '0.0') ?? 0.0,
      available: json['available'] ?? false,
      hotelId: json['hotel'] ?? 0,
    );
  }
}
