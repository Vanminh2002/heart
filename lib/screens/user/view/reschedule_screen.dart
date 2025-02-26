import 'package:flutter/material.dart';
import 'package:heart/models/appointment.dart';
import 'package:heart/models/doctor.dart';
import 'package:heart/services/appointment_service.dart';

import 'package:heart/services/doctor_services.dart';

class RescheduleScreen extends StatefulWidget {
  final Appointment appointment;

  const RescheduleScreen({Key? key, required this.appointment}) : super(key: key);

  @override
  _RescheduleScreenState createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Doctor? selectedDoctor;
  List<Doctor> doctors = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
    _initializeSelectedValues();
  }

  // Gán giá trị mặc định từ cuộc hẹn hiện tại
  void _initializeSelectedValues() {
    selectedDate = DateTime.parse(widget.appointment.date); // Gán ngày hiện tại
    selectedTime = TimeOfDay(
      hour: int.parse(widget.appointment.time.split(":")[0]),
      minute: int.parse(widget.appointment.time.split(":")[1]),
    );
  }

  Future<void> fetchDoctors() async {
    doctors = await DoctorServices().fetchDoctors();
    selectedDoctor = doctors.firstWhere(
          (doctor) => doctor.id == widget.appointment.doctorId,
      orElse: () => doctors.first,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reschedule Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Doctor: ${widget.appointment.doctorName}", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Current Date: ${widget.appointment.date}", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            // Chọn bác sĩ mới
            DropdownButton<Doctor>(
              hint: Text("Select New Doctor"),
              value: selectedDoctor,
              onChanged: (Doctor? newDoctor) {
                setState(() => selectedDoctor = newDoctor);
              },
              items: doctors.map((doctor) {
                return DropdownMenuItem(
                  value: doctor,
                  child: Text(doctor.fullName),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Chọn ngày mới
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() => selectedDate = pickedDate);
                }
              },
              child: Text("New Date: ${selectedDate?.toString().split(" ")[0] ?? "Pick Date"}"),
            ),
            const SizedBox(height: 10),

            // Chọn giờ mới
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime ?? TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() => selectedTime = pickedTime);
                }
              },
              child: Text("New Time: ${selectedTime?.format(context) ?? "Pick Time"}"),
            ),
            const SizedBox(height: 20),

            // Nút xác nhận cập nhật
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                setState(() => isLoading = true);

                final Map<String, dynamic> updateData = {};
                if (selectedDate != null) {
                  updateData["date"] = selectedDate.toString().split(" ")[0];
                }
                if (selectedTime != null) {
                  updateData["time"] = "${selectedTime!.hour}:${selectedTime!.minute}";
                }
                if (selectedDoctor != null) {
                  updateData["doctorId"] = selectedDoctor!.id;
                }

                print("📤 Sending update data: $updateData");

                bool success = await AppointmentService().updateAppointment(
                  widget.appointment.id,  // ✅ Truyền ID
                  {
                    "date": selectedDate?.toString().split(" ")[0] ?? widget.appointment.date,
                    "time": selectedTime != null ? "${selectedTime!.hour}:${selectedTime!.minute}" : widget.appointment.time,
                    "doctorId": selectedDoctor?.id ?? widget.appointment.doctorId,
                  },
                );

                setState(() => isLoading = false);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Appointment updated successfully")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to update appointment")),
                  );
                }
              },
              child: isLoading ? CircularProgressIndicator() : const Text("Confirm Reschedule"),
            ),
          ],
        ),
      ),
    );
  }
}
