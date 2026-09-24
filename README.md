<div align="center">

  <img src="https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png" width="150" alt="flutter logo">

  #  Daily Focus Task Manager
  
  **Aplikasi To-Do List**
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](https://opensource.org/licenses/MIT)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](#)

</div>

---

##  Creator

 **IXALS** 

##  Fitur Unggulan 

Aplikasi ini tidak sekadar mencatat tugas, tapi memberikan pengalaman pengguna (UX) yang menyenangkan:

### 1. Gestur Interaktif (Swipe Actions)
- **Geser Kanan (Hijau):** Tandai tugas selesai. Tugas otomatis pindah ke History.
- **Geser Kiri (Merah):** Hapus tugas jika salah ketik (disertai tombol Undo).

### 2. Detail Tugas (Rich Data)
- Menyimpan **Judul** dan **Deskripsi** dalam satu struktur data (`List<String>`).
- Klik kartu tugas untuk melihat detail lengkapnya dalam tampilan Modal yang elegan.

### 3. Hall of Fame (History)
- Halaman khusus untuk melihat pencapaian tugas yang sudah selesai.
- Fitur **Hapus Permanen** untuk membersihkan riwayat.

### 4. UI/UX 
- **Glassy Look:** Desain kartu putih bersih dengan bayangan halus.
- **Animations:** Animasi *Slide* dan *Fade* saat menambah atau menghapus tugas.
- **Greeting Header:** Sapaan personal di halaman utama.

---

## Struktur Project 

Project ini menggunakan arsitektur modular agar mudah dikembangkan dan dinilai:

```text
lib/
├── screens/
│   ├── home_screen.dart     # Logika Utama & Tampilan Home
│   └── history_screen.dart  # Halaman Riwayat Selesai
├── widgets/
│   └── todo_item.dart       # Komponen Kartu Tugas (Swipeable)
└── main.dart                # Entry Point & Tema Aplikasi
