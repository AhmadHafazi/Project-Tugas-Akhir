// Profile Page Implementation
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/db_helper.dart';
import '../../models/user_model.dart';
import 'login_page.dart';
import 'register_page.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController fullNameController;
  late TextEditingController nicknameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController regionController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.user.fullName);
    nicknameController = TextEditingController(text: widget.user.nickname);
    phoneController = TextEditingController(text: widget.user.phoneNumber);
    emailController = TextEditingController(text: widget.user.email);
    addressController = TextEditingController(text: widget.user.address);
    regionController = TextEditingController(text: widget.user.region);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void updateProfile() async {
    final updatedUser = User(
      id: widget.user.id,
      photo: _selectedImage?.path ?? widget.user.photo,
      fullName: fullNameController.text,
      nickname: nicknameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      password: widget.user.password, // Keep the existing password
      address: addressController.text,
      region: regionController.text,
    );

    final db = DatabaseHelper.instance;
    await db.updateUser(updatedUser);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile updated successfully')));
  }

  void refreshData() async {
    final db = DatabaseHelper.instance;
    final updatedUser = await db.getAllUsers();
    if (updatedUser.isNotEmpty) {}
    setState(() {
      // currentUser = updatedUser;
    });
  }

  void deleteAccount() async {
    final db = DatabaseHelper.instance;
    await db.deleteUser(widget.user.id!);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterPage()), // Assuming RegisterPage exists
      (route) => false,
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   fullNameController.dispose();
  //   nicknameController.dispose();
  //   phoneController.dispose();
  //   emailController.dispose();
  //   addressController.dispose();
  //   regionController.dispose();
  // }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            // onPressed: () => deleteAccount(),
            onPressed: () async {
              final confirm = await showDialog(
                context: context,
                builder: (contex) => AlertDialog(
                  title: Text("Delete Account"),
                  content:
                      Text("Are you sure you want to delete your account?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Delete"),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                deleteAccount();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 252, 249, 244),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                CircularImageWithIcon(
                  icon: Icons.edit,
                  iconSize: 25,
                  onIconTap: () {
                    pickImage();
                  },
                  imageUrl: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : FileImage(File(widget.user.photo)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: fullNameController,
                  cursorColor: Colors.orange.shade800,
                  style: TextStyle(color: Colors.orange.shade800),
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: Colors.orange.shade800,
                  style: TextStyle(color: Colors.orange.shade800),
                  controller: nicknameController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300], // Latar belakang abu-abu muda
                    filled: true,
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.orange.shade800,
                  style: TextStyle(color: Colors.orange.shade800),
                  controller: phoneController,
                  decoration: InputDecoration(
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.orange.shade800,
                  style: TextStyle(color: Colors.orange.shade800),
                  controller: emailController,
                  decoration: InputDecoration(
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.orange.shade800,
                  style: TextStyle(color: Colors.orange.shade800),
                  controller: addressController,
                  decoration: InputDecoration(
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  // focusNode: FocusNode(),
                  clipBehavior: Clip.none,
                  controller: regionController,
                  style: TextStyle(color: Colors.orange.shade800),
                  cursorColor: Colors.orange.shade800,
                  decoration: InputDecoration(
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
                    hintStyle: TextStyle(color: Colors.orange.shade800),
                    helperStyle: TextStyle(color: Colors.orange.shade800),
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                  ),
                  onPressed: () {
                    setState(() {
                      updateProfile();
                      refreshData();
                    });
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                //    SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        mini: true,
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () {
          logout(context);
        },
      ),
    );
  }
}

class CircularImageWithIcon extends StatelessWidget {
  final ImageProvider<Object> imageUrl;
  final IconData icon;
  final double iconSize;
  final VoidCallback onIconTap;

  const CircularImageWithIcon({
    super.key,
    required this.imageUrl,
    required this.icon,
    required this.iconSize,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gambar bulat
        CircleAvatar(
          radius: 50, // Ukuran lingkaran
          backgroundImage: imageUrl,
        ),
        // Ikon di pojok kanan bawah
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onIconTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade800,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                icon,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
