import 'dart:io';
import 'dart:typed_data';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EmailService {
  final String username = 'buvanesifet26@gmail.com'; // Your Gmail email address
  final String password = "jfqm cryc neld xjaz"; // Your Gmail email password

  Future<void> sendEmail(String recipient, Uint8List pdfData) async {
    final smtpServer = gmail(username, password);

    // Save the PDF to a temporary file
    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, 'student_details.pdf');
    final file = File(filePath);
    await file.writeAsBytes(pdfData);

    final message = Message()
      ..from = Address(username, 'Student Mate')
      ..recipients.add(recipient)
      ..subject = 'Student Details PDF'
      ..text = 'Please find attached the PDF containing the student details.'
      ..attachments = [
        FileAttachment(file)
          ..location = Location.inline
          ..cid = '<student_details.pdf>',
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Message not sent. $e');
    }
  }
}
