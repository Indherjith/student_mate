import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:student_mate/students_provider.dart';

class PdfService {
  Future<Uint8List> createPdf(Student student) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Student Details',
                  style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text('Name: ${student.name}'),
              pw.Text('Email: ${student.email}'),
              pw.Text('Contact: ${student.contact}'),
              pw.Text('Blood Group: ${student.bloodGroup}'),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
