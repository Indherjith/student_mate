import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../students_provider.dart';

class EditStudentPage extends StatefulWidget {
  final Student student;

  const EditStudentPage({super.key, required this.student});

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _contact = '';
  String _bloodGroup = '';

  @override
  void initState() {
    super.initState();
    _name = widget.student.name;
    _email = widget.student.email;
    _contact = widget.student.contact;
    _bloodGroup = widget.student.bloodGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a name';
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter an email';
                  return null;
                },
              ),
              TextFormField(
                initialValue: _contact,
                decoration: const InputDecoration(labelText: 'Contact'),
                onSaved: (value) => _contact = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a contact number';
                  return null;
                },
              ),
              TextFormField(
                initialValue: _bloodGroup,
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
                    final updatedStudent = Student(
                      id: widget.student.id,
                      name: _name,
                      email: _email,
                      contact: _contact,
                      bloodGroup: _bloodGroup,
                    );
                    Provider.of<StudentsProvider>(context, listen: false)
                        .updateStudent(updatedStudent);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
