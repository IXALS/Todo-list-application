import 'package:flutter/material.dart';
import '../widgets/todo_item.dart';
import 'history_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<String> _tugasRizzaldy = [
    'Menyelesaikan Modul Flutter',
    'Mengerjakan Laporan KP',
    'Beli Kopi buat Begadang',
  ];

  final List<String> _riwayatRizzaldy = [];
  final TextEditingController _inputController = TextEditingController();

  void _tambahTugas() {
    if (_inputController.text.isNotEmpty) {
      _tugasRizzaldy.insert(0, _inputController.text);
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 600));
      _inputController.clear();
      Navigator.of(context).pop();
    }
  }

  void _selesaikanTugas(int index) {
    String tugasSelesai = _tugasRizzaldy[index];

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => TodoItem(
        task: tugasSelesai, 
        animation: animation, 
        index: index, 
        onCompleted: () {}, 
        isRemoving: true
      ),
      duration: const Duration(milliseconds: 500),
    );

    _tugasRizzaldy.removeAt(index);
    
    setState(() {
      _riwayatRizzaldy.insert(0, tugasSelesai);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text('Selesai: "$tugasSelesai"')),
          ],
        ),
      ),
    );
  }

  void _tampilkanDialogInput() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('✨ Target Baru', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _inputController,
            autofocus: true,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: "Apa rencanamu?",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.edit_note, color: Colors.indigo),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              onPressed: _tambahTugas,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.rocket_launch, size: 18),
              label: const Text('GASKAN'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Daily Focus 🎯', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
            Text('Rizz-aldy Workspace', style: TextStyle(fontSize: 14, color: Colors.white70)),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FloatingActionButton.small(
              heroTag: 'history_btn',
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => HistoryScreen(historyList: _riwayatRizzaldy),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                      child: child,
                    );
                  },
                ));
              },
              backgroundColor: Colors.white.withOpacity(0.2),
              elevation: 0,
              child: const Icon(Icons.history, color: Colors.white),
            ),
          ),
        ],
      ),
      
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tugas Tersedia (${_tugasRizzaldy.length})", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: _tugasRizzaldy.isEmpty
                ? Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.task_alt, size: 100, color: Colors.indigo.withOpacity(0.5)),
                                const SizedBox(height: 20),
                                const Text("Relax! Semua beres 😎", style: TextStyle(fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: _tugasRizzaldy.length,
                    itemBuilder: (context, index, animation) {
                      return TodoItem(
                        task: _tugasRizzaldy[index], 
                        animation: animation, 
                        index: index,
                        onCompleted: () => _selesaikanTugas(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tampilkanDialogInput,
        backgroundColor: Colors.indigo,
        elevation: 4,
        icon: const Icon(Icons.add_task, color: Colors.white),
        label: const Text('Tambah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}