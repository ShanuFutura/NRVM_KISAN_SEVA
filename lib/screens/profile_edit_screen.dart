import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String routeName = 'doc Profile edit';
  @override
  State<ProfileEditScreen> createState() => _PatientProfilEditScreenState();
}

class _PatientProfilEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  var _name = '';

  var _email = '';

  var _phone = '';

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: 'name',
                style: const TextStyle(color: Colors.black),
                key: const ValueKey('nm'),
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return 'patient name cannot be empty';
                  } else if (v.trim().length < 3) {
                    return 'enter a valid name';
                  }
                },
                onSaved: (vl) {
                  _name = vl!;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                initialValue: 'username',
                style: const TextStyle(color: Colors.black),
                key: const ValueKey('un'),
                validator: (v) {
                  return v!.isEmpty ? 'username cannot be empty' : null;
                },
                onSaved: (vl) {
                  _email = vl!;
                },
                decoration: const InputDecoration(
                  hintText: 'username',
                  labelText: 'username',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                initialValue: 'mail id',
                style: const TextStyle(color: Colors.black),
                key: const ValueKey('em'),
                validator: (v) {
                  return v!.isEmpty ? 'email cannot be empty' : null;
                },
                onSaved: (vl) {
                  _email = vl!;
                },
                decoration: const InputDecoration(
                  hintText: 'email id',
                  labelText: 'email',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextFormField(
                initialValue: 'pmob',
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                key: const ValueKey('mob'),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'phone number cannot be empty';
                  } else if (v.length > 11 || v.length < 10) {
                    return 'Enter valid phone number';
                  }
                  return null;
                },
                onSaved: (vl) {
                  _phone = vl!;
                },
                decoration: const InputDecoration(
                  labelText: 'phone',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: trySubmit, child:  const Text('EDIT'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
