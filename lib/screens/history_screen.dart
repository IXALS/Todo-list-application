import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final List<String> historyList;
  const HistoryScreen({super.key, required this.historyList});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  
  void _hapusPermanen(int index) {
    setState(() {
      widget.historyList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Dihapus permanen dari sejarah."), duration: Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Hall of Fame 🏆'), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true),
      body: widget.historyList.isEmpty
          ? Center(child: Text("Belum ada riwayat...", style: TextStyle(color: Colors.grey[400])))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: widget.historyList.length,
              itemBuilder: (context, index) {
                // Pecah data juga di sini buat ditampilkan
                String raw = widget.historyList[index];
                String title = raw.split('|||')[0];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[100]!),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 28),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                      ),
                      IconButton(
                        onPressed: () => _hapusPermanen(index), // Tombol Hapus
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}