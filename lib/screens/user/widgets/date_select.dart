import 'package:flutter/material.dart';
class DateSelect extends StatefulWidget {
  final String maintext;
  final String date;
  final Function(bool isSelected)? onSelected; // Callback để thông báo trạng thái

  const DateSelect({
    super.key,
    required this.maintext,
    required this.date,
    this.onSelected, required bool isSelected,
  });

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  bool isSelected = false;

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });

    // Gọi callback nếu có
    if (widget.onSelected != null) {
      widget.onSelected!(isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 2, 179, 149)
                : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.maintext,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black54,
                ),
              ),
              Text(
                widget.date,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? Colors.white
                      : const Color.fromARGB(255, 27, 27, 27),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
