// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/db_helper.dart';
import '../../models/user_model.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _image;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

/*************  ✨ Codeium Command ⭐  *************/
  /// Opens the gallery to select an image. If an image is selected, set it to
  /// [_image].
  ///
  /// Returns a [Future] that resolves when the image is selected.
  /// ****  cb38e315-1b83-4332-b310-85fb228efb9b  ******
  //fungsi membuka image dari galeri
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//fungsi registrasi user
  void registerUser() async {
    //melakukan validasi harus memilih image dahulu, memunculkan snackbar
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please select a photo')));
        return;
      }
//insert ke database dengan data sesuai model
      final db = DatabaseHelper.instance;
      await db.insertUser(
        User(
          photo: _image!.path,
          fullName: fullNameController.text,
          nickname: nicknameController.text,
          phoneNumber: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
          address: addressController.text,
          region: regionController.text,
        ),
      );
// navigasi ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Register',
            style: TextStyle(color: Colors.orange.shade800, fontSize: 30),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.orange.shade800,
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  controller: fullNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter full name' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  controller: nicknameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Nickname',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter nickname' : null,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.orange.shade800,
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter phone number' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.orange.shade800,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter email' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter password' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  controller: addressController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter address' : null,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  controller: regionController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                    focusColor: Colors.orange.shade800,
                    hoverColor: Colors.orange.shade800,
                    fillColor: Colors.orange.shade800,
                    labelText: 'Region',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade800),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Default border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused border
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Error border
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange.shade800,
                      ), // Focused error border
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter region' : null,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                //button simpan memanggil fungsi register
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                  ),
                  onPressed: () {
                    registerUser();
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
