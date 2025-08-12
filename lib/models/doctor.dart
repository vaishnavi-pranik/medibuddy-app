class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final String fee;
  final String consultationFee;
  final List<String> availability;
  final String location;
  final String imageUrl;
  final String hospital;
  final String contact;
  final String degree;
  final List<String> languages;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.fee,
    required this.consultationFee,
    required this.availability,
    required this.location,
    required this.imageUrl,
    required this.hospital,
    required this.contact,
    required this.degree,
    required this.languages,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      experience: json['experience'] as String,
      rating: (json['rating'] as num).toDouble(),
      fee: json['fee'] as String,
      consultationFee: json['consultationFee'] as String,
      availability: List<String>.from(json['availability'] as List),
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      hospital: json['hospital'] as String,
      contact: json['contact'] as String,
      degree: json['degree'] as String,
      languages: List<String>.from(json['languages'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'experience': experience,
      'rating': rating,
      'fee': fee,
      'consultationFee': consultationFee,
      'availability': availability,
      'location': location,
      'imageUrl': imageUrl,
      'hospital': hospital,
      'contact': contact,
      'degree': degree,
      'languages': languages,
    };
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? specialty,
    String? experience,
    double? rating,
    String? fee,
    String? consultationFee,
    List<String>? availability,
    String? location,
    String? imageUrl,
    String? hospital,
    String? contact,
    String? degree,
    List<String>? languages,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      fee: fee ?? this.fee,
      consultationFee: consultationFee ?? this.consultationFee,
      availability: availability ?? this.availability,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      hospital: hospital ?? this.hospital,
      contact: contact ?? this.contact,
      degree: degree ?? this.degree,
      languages: languages ?? this.languages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Doctor &&
        other.id == id &&
        other.name == name &&
        other.specialty == specialty &&
        other.experience == experience &&
        other.rating == rating &&
        other.fee == fee &&
        other.consultationFee == consultationFee &&
        _listEquals(other.availability, availability) &&
        other.location == location &&
        other.imageUrl == imageUrl &&
        other.hospital == hospital &&
        other.contact == contact &&
        other.degree == degree &&
        _listEquals(other.languages, languages);
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        specialty.hashCode ^
        experience.hashCode ^
        rating.hashCode ^
        fee.hashCode ^
        consultationFee.hashCode ^
        availability.hashCode ^
        location.hashCode ^
        imageUrl.hashCode ^
        hospital.hashCode ^
        contact.hashCode ^
        degree.hashCode ^
        languages.hashCode;
  }

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, specialty: $specialty, rating: $rating)';
  }

  // Helper methods
  bool isAvailableOn(String day) {
    return availability.contains(day);
  }

  String get shortExperience {
    return experience.replaceAll(' years', 'y');
  }

  String get displayLocation {
    return '$hospital, $location';
  }

  String get primaryLanguage {
    return languages.isNotEmpty ? languages.first : 'English';
  }

  String get languagesDisplay {
    if (languages.length <= 2) {
      return languages.join(', ');
    } else {
      return '${languages.take(2).join(', ')}, +${languages.length - 2} more';
    }
  }
}
