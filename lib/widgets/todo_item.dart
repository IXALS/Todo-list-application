import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String taskString; // Isinya: "Judul|||Deskripsi"
  final int index;
  final Function(int) onSwipeSelesai; // Geser Kanan (Hijau)
  final Function(int) onSwipeHapus;   // Geser Kiri (Merah)
  final Function() onTapDetail;       // Klik buat lihat detail

  const TodoItem({
    super.key,
    required this.taskString,
    required this.index,
    required this.onSwipeSelesai,
    required this.onSwipeHapus,
    required this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Pecah Data (Judul vs Deskripsi)
    List<String> parts = taskString.split('|||');
    String title = parts[0];
    String desc = parts.length > 1 ? parts[1] : '';

    return Dismissible(
      key: Key(taskString + index.toString()),
      
      // 2. Background Geser Kanan (SELESAI - HIJAU)
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF00C853),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(left: 24),
        alignment: Alignment.centerLeft,
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 30),
            SizedBox(width: 10),
            Text("Selesai!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),

      // 3. Background Geser Kiri (HAPUS - MERAH)
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3D00), // Merah terang
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Hapus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Icon(Icons.delete_forever, color: Colors.white, size: 30),
          ],
        ),
      ),

      // 4. Logika Arah Geser
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onSwipeSelesai(index); // Ke Kanan -> Selesai
        } else {
          onSwipeHapus(index);   // Ke Kiri -> Hapus
        }
      },

      // 5. Tampilan Kartu
      child: GestureDetector(
        onTap: onTapDetail, // Klik buat lihat detail
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 20),
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
            subtitle: desc.isNotEmpty 
              ? Text(desc, maxLines: 1, overflow: TextOverflow.ellipsis) 
              : null,
            trailing: const Icon(Icons.info_outline_rounded, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}