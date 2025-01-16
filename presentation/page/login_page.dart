// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../helpers/db_helper.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

//fungsi login
  void loginUser() async {
    final db = DatabaseHelper.instance;
    final user = await db.getUserByNicknameAndPassword(
      nicknameController.text,
      passwordController.text,
    );

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(color: Colors.orange.shade800, fontSize: 30),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
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
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
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
            ),
            Spacer(),

            //button memanggil fungsi login
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              onPressed: () {
                loginUser();
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
