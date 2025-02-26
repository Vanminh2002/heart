import 'package:flutter/material.dart';
import 'package:heart/models/doctor.dart';
import 'package:heart/models/patient.dart';
import '../../../models/appointment.dart';
import '../../../services/appointment_service.dart';

class AppointmentScreen extends StatefulWidget {
  final int? appointmentId; // Thêm thuộc tính appointmentId
  final Patient? patient;
  final Doctor? doctor;
  final int doctorId;
  final String selectedDate;
  final String selectedTime;

  const AppointmentScreen({
    super.key,
    required this.patient,
    this.doctor,
    required this.doctorId,
    required this.selectedDate,
    required this.selectedTime,
    this.appointmentId, // Thêm vào để truyền appointmentId
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int? _appointmentId; // 👈 Thêm biến này
  final AppointmentService _appointmentService = AppointmentService();


  @override
  void initState() {
    super.initState();
    _appointmentId = widget.appointmentId; // Gán giá trị ban đầu từ widget
  }

  Future<void> bookAppointment() async {
    if (widget.patient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Patient not selected!')),
      );
      return;
    }

    try {
      final request = AppointmentRequest(
        id: _appointmentId, // Giữ nguyên ID nếu đã có
        patientId: widget.patient!.id,
        doctorId: widget.doctorId,
        date: widget.selectedDate,
        time: widget.selectedTime,
      );

      final response = await _appointmentService.bookAppointment(request);

      setState(() {
        _appointmentId = response.id; // Cập nhật ID sau khi đặt lịch thành công
      });

      ScaffoldMessenger.of(context).showSnackBar(
          // ID: ${response.id}
        SnackBar(content: Text('Appointment booked successfully! ')),
      );

      Navigator.pop(context, response.id); // Trả ID về màn hình trước nếu cần
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error booking appointment: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentId = widget.appointmentId; // Lấy appointmentId từ widget

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Confirmation', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Doctor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(widget.doctor?.fullName ?? "Unknown", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text("Patient", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(widget.patient?.fullName ?? "Unknown", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text("Date & Time", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("${widget.selectedDate} at ${widget.selectedTime}", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Hiển thị appointmentId nếu có
            if (appointmentId != null)
              Text("Appointment ID: $appointmentId", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (_appointmentId != null)
              Text("Appointment ID: $_appointmentId",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Back", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF02B395),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Confirm Appointment", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

