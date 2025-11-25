import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String task;
  final Animation<double> animation;
  final int index;
  final VoidCallback onCompleted;
  final bool isRemoving;

  const TodoItem({
    super.key,
    required this.task,
    required this.animation,
    required this.index,
    required this.onCompleted,
    this.isRemoving = false,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuart)),
      
      child: FadeTransition(
        opacity: animation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isRemoving ? Colors.green.withOpacity(0.3) : Colors.indigo.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.work_outline, color: Colors.indigo, size: 20),
            ),
            title: Text(
              task,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            trailing: InkWell(
              onTap: onCompleted,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.green, size: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}