class ParkingSlotModels {
  final int id;
  final String cretedby;
  final String createdbyname;
  final String address;
  final double longitude;
  final double latitude;
  final double perhourrate;

  ParkingSlotModels({
    required this.id,
    required this.cretedby,
    required this.createdbyname,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.perhourrate,
  });

  factory ParkingSlotModels.fromJson(Map<String, dynamic> json) {
    return ParkingSlotModels(
      id: json['id'],
      cretedby: json['created_by'],
      createdbyname: json['created_by_name'],
      address: json['address'],
      longitude: json['logitude'],
      latitude: json['latitude'],
      perhourrate: json['per_hour_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': cretedby,
      'created_by_name': createdbyname,
      'address': address,
      'logitude': longitude,
      'latitude': latitude,
      'per_hour_rate': perhourrate,
    };
  }
}
