import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../students_provider.dart';

class CreateStudentPage extends StatefulWidget {
  const CreateStudentPage({super.key});

  @override
  _CreateStudentPageState createState() => _CreateStudentPageState();
}

class _CreateStudentPageState extends State<CreateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _contact = '';
  String _bloodGroup = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a name';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter an email';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact'),
                onSaved: (value) => _contact = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a contact number';
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blood Group'),
                onSaved: (value) => _bloodGroup = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a blood group';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    final newStudent = Student(
                      name: _name,
                      email: _email,
                      contact: _contact,
                      bloodGroup: _bloodGroup,
                      id: '',
                    );
                    Provider.of<StudentsProvider>(context, listen: false)
                        .addStudent(newStudent);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
