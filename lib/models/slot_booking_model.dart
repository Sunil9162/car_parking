class SlotBookingModels {
  final String createdby;
  final String createdbyname;
  final int slot;
  final String starttime;
  final String endtime;
  final bool isactive;
  final bool ispaid;

  SlotBookingModels({
    required this.createdby,
    required this.createdbyname,
    required this.slot,
    required this.starttime,
    required this.endtime,
    required this.isactive,
    required this.ispaid,
  });

  factory SlotBookingModels.fromJson(Map<String, dynamic> json) {
    return SlotBookingModels(
      createdby: json['created_by'],
      createdbyname: json['created_by_name'],
      slot: json['slot'],
      starttime: json['start_time'],
      endtime: json['end_time'],
      isactive: json['is_active'],
      ispaid: json['is_paid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_by_name': createdbyname,
      'created_by': createdby,
      'slot': slot,
      'start_time': starttime,
      'end_time': endtime,
      'is_active': isactive,
      'is_paid': ispaid,
    };
  }
}
