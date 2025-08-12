import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/appointment.dart';
import '../models/doctor.dart';

class AppointmentProvider with ChangeNotifier {
  final List<Appointment> _appointments = [];
  final List<Doctor> _doctors = [];
  bool _isLoading = false;

  List<Appointment> get appointments => _appointments;
  List<Doctor> get doctors => _doctors;
  bool get isLoading => _isLoading;

  List<Appointment> get upcomingAppointments {
    final now = DateTime.now();
    return _appointments
        .where((appointment) => appointment.dateTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  List<Appointment> get pastAppointments {
    final now = DateTime.now();
    return _appointments
        .where((appointment) => appointment.dateTime.isBefore(now))
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  static const String _appointmentsKey = 'appointments';
  static const String _doctorsKey = 'doctors';

  AppointmentProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([_loadAppointments(), _loadDoctors()]);
    } catch (e) {
      print('Error loading appointment data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final appointmentsData = prefs.getString(_appointmentsKey);
      
      if (appointmentsData != null) {
        final appointmentsList = jsonDecode(appointmentsData) as List;
        _appointments.clear();
        _appointments.addAll(
          appointmentsList.map((data) => Appointment.fromJson(data)).toList(),
        );
      } else {
        // Initialize with sample appointments
        await _initializeSampleAppointments();
      }
    } catch (e) {
      print('Error loading appointments: $e');
    }
  }

  Future<void> _loadDoctors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final doctorsData = prefs.getString(_doctorsKey);
      
      if (doctorsData != null) {
        final doctorsList = jsonDecode(doctorsData) as List;
        _doctors.clear();
        _doctors.addAll(
          doctorsList.map((data) => Doctor.fromJson(data)).toList(),
        );
      } else {
        // Initialize with sample doctors
        await _initializeSampleDoctors();
      }
    } catch (e) {
      print('Error loading doctors: $e');
    }
  }

  Future<void> _initializeSampleDoctors() async {
    final sampleDoctors = [
      Doctor(
        id: '1',
        name: 'Dr. Priya Sharma',
        specialty: 'General Physician',
        experience: '15 years',
        rating: 4.8,
        fee: '₹500',
        consultationFee: '₹500',
        availability: ['Monday', 'Tuesday', 'Wednesday', 'Friday'],
        location: 'Delhi',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Apollo Hospital',
        contact: '+91 9876543210',
        degree: 'MBBS, MD (Internal Medicine)',
        languages: ['English', 'Hindi', 'Tamil'],
      ),
      Doctor(
        id: '2',
        name: 'Dr. Rajesh Kumar',
        specialty: 'Cardiologist',
        experience: '20 years',
        rating: 4.9,
        fee: '₹800',
        consultationFee: '₹800',
        availability: ['Monday', 'Wednesday', 'Thursday', 'Saturday'],
        location: 'Mumbai',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Fortis Hospital',
        contact: '+91 9876543211',
        degree: 'MBBS, MD (Cardiology)',
        languages: ['English', 'Hindi'],
      ),
      Doctor(
        id: '3',
        name: 'Dr. Anitha Nair',
        specialty: 'Pediatrician',
        experience: '12 years',
        rating: 4.7,
        fee: '₹600',
        consultationFee: '₹600',
        availability: ['Tuesday', 'Thursday', 'Friday', 'Saturday'],
        location: 'Bangalore',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Max Healthcare',
        contact: '+91 9876543212',
        degree: 'MBBS, MD (Pediatrics)',
        languages: ['English', 'Hindi', 'Malayalam'],
      ),
      Doctor(
        id: '4',
        name: 'Dr. Amit Patel',
        specialty: 'Dermatologist',
        experience: '10 years',
        rating: 4.6,
        fee: '₹700',
        consultationFee: '₹700',
        availability: ['Monday', 'Tuesday', 'Friday', 'Sunday'],
        location: 'Chennai',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Manipal Hospital',
        contact: '+91 9876543213',
        degree: 'MBBS, MD (Dermatology)',
        languages: ['English', 'Hindi', 'Gujarati'],
      ),
      Doctor(
        id: '5',
        name: 'Dr. Sunita Singh',
        specialty: 'Gynecologist',
        experience: '18 years',
        rating: 4.8,
        fee: '₹750',
        consultationFee: '₹750',
        availability: ['Wednesday', 'Thursday', 'Friday', 'Saturday'],
        location: 'Pune',
        imageUrl: 'https://via.placeholder.com/150',
        hospital: 'Cloudnine Hospital',
        contact: '+91 9876543214',
        degree: 'MBBS, MS (Obstetrics & Gynecology)',
        languages: ['English', 'Hindi'],
      ),
    ];

    _doctors.addAll(sampleDoctors.cast<Doctor>());
    await _saveDoctors();
  }

  Future<void> _initializeSampleAppointments() async {
    final sampleAppointments = [
      Appointment(
        id: '1',
        doctorId: '1',
        doctorName: 'Dr. Priya Sharma',
        specialty: 'General Physician',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        type: 'In-person',
        status: 'confirmed',
        notes: 'Annual health checkup',
        hospital: 'Apollo Hospital',
      ),
    ];

    _appointments.addAll(sampleAppointments);
    await _saveAppointments();
  }

  Future<void> _saveAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final appointmentsJson = _appointments.map((appointment) => appointment.toJson()).toList();
      await prefs.setString(_appointmentsKey, jsonEncode(appointmentsJson));
    } catch (e) {
      print('Error saving appointments: $e');
    }
  }

  Future<void> _saveDoctors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final doctorsJson = _doctors.map((doctor) => doctor.toJson()).toList();
      await prefs.setString(_doctorsKey, jsonEncode(doctorsJson));
    } catch (e) {
      print('Error saving doctors: $e');
    }
  }

  Future<bool> bookAppointment({
    required String doctorId,
    required DateTime dateTime,
    required String type,
    String? notes,
  }) async {
    try {
      final doctor = _doctors.firstWhere((d) => d.id == doctorId);
      
      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        doctorId: doctorId,
        doctorName: doctor.name,
        specialty: doctor.specialty,
        dateTime: dateTime,
        type: type,
        status: 'confirmed',
        notes: notes ?? '',
        hospital: doctor.hospital,
      );

      _appointments.add(newAppointment);
      notifyListeners();
      await _saveAppointments();
      return true;
    } catch (e) {
      print('Error booking appointment: $e');
      return false;
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      final appointmentIndex = _appointments.indexWhere((a) => a.id == appointmentId);
      if (appointmentIndex != -1) {
        _appointments[appointmentIndex] = _appointments[appointmentIndex].copyWith(
          status: 'cancelled',
        );
        notifyListeners();
        await _saveAppointments();
        return true;
      }
      return false;
    } catch (e) {
      print('Error cancelling appointment: $e');
      return false;
    }
  }

  Future<bool> rescheduleAppointment(String appointmentId, DateTime newDateTime) async {
    try {
      final appointmentIndex = _appointments.indexWhere((a) => a.id == appointmentId);
      if (appointmentIndex != -1) {
        _appointments[appointmentIndex] = _appointments[appointmentIndex].copyWith(
          dateTime: newDateTime,
        );
        notifyListeners();
        await _saveAppointments();
        return true;
      }
      return false;
    } catch (e) {
      print('Error rescheduling appointment: $e');
      return false;
    }
  }

  Doctor? getDoctorById(String doctorId) {
    try {
      return _doctors.firstWhere((doctor) => doctor.id == doctorId);
    } catch (e) {
      return null;
    }
  }

  List<Doctor> searchDoctors(String query) {
    if (query.isEmpty) return _doctors;
    
    final lowercaseQuery = query.toLowerCase();
    return _doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(lowercaseQuery) ||
             doctor.specialty.toLowerCase().contains(lowercaseQuery) ||
             doctor.hospital.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Doctor> getDoctorsBySpecialty(String specialty) {
    return _doctors.where((doctor) => doctor.specialty == specialty).toList();
  }

  Future<void> refreshData() async {
    await _loadData();
  }
}
