import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../students_provider.dart';
import 'student_details_page.dart';
import 'create_student_page.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch students when the page initializes
    Future.microtask(() =>
        Provider.of<StudentsProvider>(context, listen: false).fetchStudents());
  }

  @override
  Widget build(BuildContext context) {
    final studentsProvider = Provider.of<StudentsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: studentsProvider.students.isEmpty
          ? const Center(child: Text('No Data Available'))
          : ListView.builder(
              itemCount: studentsProvider.students.length,
              itemBuilder: (context, index) {
                final student = studentsProvider.students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailsPage(student: student),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateStudentPage(),
            ),
          );
        },
      ),
    );
  }
}
