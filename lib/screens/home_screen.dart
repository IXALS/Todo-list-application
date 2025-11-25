import 'package:flutter/material.dart';
import '../widgets/todo_item.dart';
import 'history_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // DATA DISIMPAN SEBAGAI: "Judul|||Deskripsi"
  final List<String> _tugasRizzaldy = [
    'Menyelesaikan Modul Flutter|||Bab 1 sampai Bab 5 harus kelar hari ini',
    'Mengerjakan Laporan KP|||Revisi Bab 4 bagian kesimpulan',
    'Beli Kopi|||Kopi susu gula aren less ice',
  ];

  final List<String> _riwayatRizzaldy = [];
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  // --- LOGIKA ---

  void _tambahTugas() {
    if (_judulController.text.isNotEmpty) {
      // GABUNGKAN JUDUL DAN DESKRIPSI DENGAN '|||'
      String fullData = "${_judulController.text}|||${_deskripsiController.text}";
      
      setState(() {
        _tugasRizzaldy.insert(0, fullData);
      });
      _judulController.clear();
      _deskripsiController.clear();
      Navigator.of(context).pop();
    }
  }

  void _geserSelesai(int index) {
    String data = _tugasRizzaldy[index];
    setState(() {
      _tugasRizzaldy.removeAt(index);
      _riwayatRizzaldy.insert(0, data);
    });
    // Feedback
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mantap! Tugas Selesai ✅"), backgroundColor: Colors.green));
  }

  void _geserHapus(int index) {
    String data = _tugasRizzaldy[index];
    setState(() {
      _tugasRizzaldy.removeAt(index);
    });
    // Feedback Undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Tugas dihapus 🗑️"),
        backgroundColor: Colors.redAccent,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () => setState(() => _tugasRizzaldy.insert(index, data)),
        ),
      ),
    );
  }

  // --- UI DIALOGS ---

  void _lihatDetail(String taskString) {
    List<String> parts = taskString.split('|||');
    String title = parts[0];
    String desc = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : "Tidak ada deskripsi tambahan.";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Detail Tugas", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(15)),
                child: Text(desc, style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _tampilkanDialogInput() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("✨ Target Baru", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                // INPUT JUDUL
                TextField(
                  controller: _judulController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Judul Tugas (Wajib)",
                    filled: true, fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 10),
                // INPUT DESKRIPSI
                TextField(
                  controller: _deskripsiController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Catatan tambahan (Opsional)...",
                    filled: true, fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal", style: TextStyle(color: Colors.grey))),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _tambahTugas,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2575FC), foregroundColor: Colors.white),
                      child: const Text("Simpan"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Column(
        children: [
          // HEADER (Sama seperti sebelumnya)
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 5))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Hello, Rizz-aldy!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                  Text("Let's be productive.", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ]),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen(historyList: _riwayatRizzaldy))),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.history, color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
          // LIST
          Expanded(
            child: _tugasRizzaldy.isEmpty
                ? const Center(child: Text("Semua beres! Santai dulu. 😎", style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: _tugasRizzaldy.length,
                    itemBuilder: (context, index) {
                      return TodoItem(
                        taskString: _tugasRizzaldy[index], // Kirim string mentah
                        index: index,
                        onSwipeSelesai: _geserSelesai, // Kanan
                        onSwipeHapus: _geserHapus,     // Kiri
                        onTapDetail: () => _lihatDetail(_tugasRizzaldy[index]), // Klik
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tampilkanDialogInput,
        backgroundColor: const Color(0xFF2575FC),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}