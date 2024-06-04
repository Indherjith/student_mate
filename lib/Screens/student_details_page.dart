import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../students_provider.dart';
import 'edit_student_page.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final studentsProvider = Provider.of<StudentsProvider>(context);
    final updatedStudent =
        studentsProvider.students.firstWhere((s) => s.id == student.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${updatedStudent.name}'),
            Text('Email: ${updatedStudent.email}'),
            Text('Contact: ${updatedStudent.contact}'),
            Text('Blood Group: ${updatedStudent.bloodGroup}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditStudentPage(student: updatedStudent),
                      ),
                    );
                  },
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    studentsProvider.deleteStudent(updatedStudent.id);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
