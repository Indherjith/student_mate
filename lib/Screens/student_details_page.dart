import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Components/pdf_service.dart';
import '../email_service.dart';
import '../students_provider.dart';
import 'edit_student_page.dart';

class StudentDetailsPage extends StatelessWidget {
  final Student student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email;

    final studentProvider = Provider.of<StudentsProvider>(context);
    final updatedStudent =
        studentProvider.students.firstWhere((s) => s.id == student.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(updatedStudent.name),
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
                    studentProvider.deleteStudent(updatedStudent.id);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final pdfService = PdfService();
                final pdfData = await pdfService.createPdf(updatedStudent);

                if (userEmail != null) {
                  final emailService = EmailService();
                  await emailService.sendEmail(userEmail, pdfData);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PDF sent to your email')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Unable to fetch current user email')),
                  );
                }
              },
              child: const Text('Get PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
