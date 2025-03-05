import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/doctor_detail_screen.dart';
import '../../../models/common.dart';
import '../../../models/medicine.dart';
import '../../../services/medicine_service.dart';

class MedicineScreen extends StatefulWidget {
  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final MedicineServices _medicineService = MedicineServices();
  late Future<List<Medicine>> _medicineList;
  List<Medicine> _filteredMedicines = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _medicineList = _medicineService.fetchMedicines();
    _medicineList.then((medicines) {
      setState(() {
        _filteredMedicines = medicines;
      });
    });
  }

  void _filterMedicines(String query) {
    _medicineList.then((medicines) {
      setState(() {
        _filteredMedicines = medicines
            .where((medicine) =>
            medicine.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách thuốc"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterMedicines,
              decoration: InputDecoration(
                labelText: "Tìm kiếm thuốc",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Medicine>>(
              future: _medicineList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi khi tải dữ liệu: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Không có dữ liệu thuốc."));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: _filteredMedicines.length,
                  itemBuilder: (context, index) {
                    Medicine medicine = _filteredMedicines[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            getFullImageUrl(medicine.imageUrl),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported, size: 60),
                          ),
                        ),
                        title: Text(
                          medicine.name,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "Liều dùng: ${medicine.dosage}\nDạng: ${medicine.form}\nNSX: ${medicine.manufacturer}",
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showMedicineDetail(context, medicine);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMedicineDetail(BuildContext context, Medicine medicine) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(medicine.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                getFullImageUrl(medicine.imageUrl), // Đảm bảo URL đầy đủ
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text("Liều dùng: ${medicine.dosage}"),
              Text("Dạng: ${medicine.form}"),
              Text("Nhà sản xuất: ${medicine.manufacturer}"),
              SizedBox(height: 10),
              Text("Mô tả: ${medicine.description}", textAlign: TextAlign.justify),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  String getFullImageUrl(String imageUrl) {
    if (imageUrl.startsWith("http")) {
      return imageUrl;
    }
    final String baseUrl = '${Common.domain}/upload/medication';
    return "$baseUrl/$imageUrl";
  }
}
