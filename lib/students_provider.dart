import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Student {
  String id;
  String name;
  String email;
  String contact;
  String bloodGroup;

  Student(
      {required this.id,
      required this.name,
      required this.email,
      required this.contact,
      required this.bloodGroup});

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      contact: data['contact'] ?? '',
      bloodGroup: data['bloodGroup'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'contact': contact,
      'bloodGroup': bloodGroup,
    };
  }
}

class StudentsProvider with ChangeNotifier {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  List<Student> _students = [];

  List<Student> get students => _students;

  Future<void> fetchStudents() async {
    try {
      QuerySnapshot snapshot = await studentsCollection.get();
      _students =
          snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  Future<void> addStudent(Student student) async {
    await studentsCollection.add(student.toMap());
    await fetchStudents();
  }

  Future<void> updateStudent(Student student) async {
    await studentsCollection.doc(student.id).update(student.toMap());
    await fetchStudents();
  }

  Future<void> deleteStudent(String id) async {
    await studentsCollection.doc(id).delete();
    await fetchStudents();
  }
}
