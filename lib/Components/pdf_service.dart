import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:student_mate/students_provider.dart';

class PdfService {
  Future<Uint8List> createPdf(Student student) async {
    final pdf = pw.Document();

    // Load font from assets
    final fontData = await rootBundle.load('assets/NotoSans-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Load image from assets
    final ByteData bytes = await rootBundle.load('assets/background.jpg');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final image = pw.MemoryImage(byteList);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Background image
              pw.Positioned.fill(
                child: pw.Image(image,
                    fit: pw.BoxFit
                        .cover), // Ensure the image fully covers the page
              ),
              // Overlay content
              pw.Padding(
                padding: const pw.EdgeInsets.all(60),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Student Details',
                      style: pw.TextStyle(
                        fontSize: 24,
                        color: PdfColors.blue, // Changed color to blue
                        font: ttf,
                      ),
                    ),
                    pw.SizedBox(height: 16),
                    pw.Text(
                      'Name: ${student.name}',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.blue, // Changed color to blue
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      'Email: ${student.email}',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.blue, // Changed color to blue
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      'Contact: ${student.contact}',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.blue, // Changed color to blue
                        font: ttf,
                      ),
                    ),
                    pw.Text(
                      'Blood Group: ${student.bloodGroup}',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.blue, // Changed color to blue
                        font: ttf,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
