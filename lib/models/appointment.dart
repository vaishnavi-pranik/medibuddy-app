class Appointment {
  final String id;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String type; // 'In-person', 'Video Call', 'Phone Call'
  final String status; // 'confirmed', 'pending', 'cancelled', 'completed'
  final String notes;
  final String hospital;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.type,
    required this.status,
    this.notes = '',
    required this.hospital,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      specialty: json['specialty'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      type: json['type'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String? ?? '',
      hospital: json['hospital'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'specialty': specialty,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
      'notes': notes,
      'hospital': hospital,
    };
  }

  Appointment copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? specialty,
    DateTime? dateTime,
    String? type,
    String? status,
    String? notes,
    String? hospital,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      hospital: hospital ?? this.hospital,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Appointment &&
        other.id == id &&
        other.doctorId == doctorId &&
        other.doctorName == doctorName &&
        other.specialty == specialty &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.status == status &&
        other.notes == notes &&
        other.hospital == hospital;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorId.hashCode ^
        doctorName.hashCode ^
        specialty.hashCode ^
        dateTime.hashCode ^
        type.hashCode ^
        status.hashCode ^
        notes.hashCode ^
        hospital.hashCode;
  }

  @override
  String toString() {
    return 'Appointment(id: $id, doctorName: $doctorName, dateTime: $dateTime, status: $status)';
  }
}
