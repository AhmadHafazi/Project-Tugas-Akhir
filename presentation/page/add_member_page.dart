// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../helpers/db_helper.dart';
// import '../../models/user_model.dart';

// class AddMemberPage extends StatefulWidget {
//   final MemberModel? member;
//   const AddMemberPage({
//     super.key,
//     this.member,
//   });

//   @override
//   State<AddMemberPage> createState() => _AddMemberPageState();
// }

// class _AddMemberPageState extends State<AddMemberPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   final _nicknameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _regionController = TextEditingController();
//   String? _photoPath;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.member != null) {
//       _fullNameController.text = widget.member!.fullName;
//       _nicknameController.text = widget.member!.nickname;
//       _phoneNumberController.text = widget.member!.phoneNumber;
//       _emailController.text = widget.member!.email;
//       _addressController.text = widget.member!.address;
//       _regionController.text = widget.member!.region;
//       _photoPath = widget.member!.photoPath;
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _fullNameController.dispose();
//     _nicknameController.dispose();
//     _phoneNumberController.dispose();
//     _emailController.dispose();
//     _addressController.dispose();
//     _regionController.dispose();
//   }

//   void _saveMember() async {
//     if (_formKey.currentState!.validate()) {
//       final member = MemberModel(
//         id: widget.member?.id,
//         fullName: _fullNameController.text,
//         nickname: _nicknameController.text,
//         phoneNumber: _phoneNumberController.text,
//         email: _emailController.text,
//         address: _addressController.text,
//         region: _regionController.text,
//         photoPath: _photoPath ?? '',
//       );

//       final dbHelper = DatabaseHelper();
//       if (widget.member == null) {
//         await dbHelper.insertMember(member);
//       } else {
//         await dbHelper.updateMember(member);
//       }

//       Navigator.pop(context);
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _photoPath = pickedFile.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.member == null ? 'Add Member' : 'Edit Member'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: _photoPath != null
//                         ? FileImage(File(_photoPath!))
//                         : null,
//                     child: _photoPath == null
//                         ? Icon(Icons.camera_alt, size: 50)
//                         : null,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: _fullNameController,
//                   decoration: InputDecoration(labelText: 'Full Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a full name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 TextFormField(
//                   controller: _nicknameController,
//                   decoration: InputDecoration(labelText: 'Nickname'),
//                 ),
//                 SizedBox(height: 8),
//                 TextFormField(
//                   controller: _phoneNumberController,
//                   decoration: InputDecoration(labelText: 'Phone Number'),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(labelText: 'Address'),
//                 ),
//                 SizedBox(height: 8),
//                 TextFormField(
//                   controller: _regionController,
//                   decoration: InputDecoration(labelText: 'Region'),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _saveMember,
//                   child: Text(widget.member == null ? 'Save' : 'Update'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
