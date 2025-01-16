// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gringsangan/presentation/widget/banner_widget.dart';
import 'package:gringsangan/presentation/widget/content_widget.dart';

import '../../helpers/db_helper.dart';
import '../../models/user_model.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User currentUser;
//inisiasi
  @override
  void initState() {
    super.initState();
    refreshUser();
  }

//fungsi untuk memperbarui data
  void refreshUser() async {
    final db = DatabaseHelper.instance;
    final updatedUser = await db.getUserByNicknameAndPassword(
        widget.user.nickname, widget.user.password);
    if (updatedUser != null) {
      setState(() {
        currentUser = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [],
        centerTitle: true,
        title: Text(
          'Gringsangan App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //menampilkan data nikname dari DB
              Text('Welcome!, \n${widget.user.fullName}',
                  style: TextStyle(fontSize: 24)),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black12,
                        offset: Offset(1, 1))
                  ],
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Center(
                  //melakukan navigasi ke halaman profile
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                user: currentUser,
                              ),
                            )).then((value) => refreshUser());
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
              )
            ]),
            SizedBox(height: 20),
            Text('Pertandigan Hari Ini', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Column(
              children: [
                BannerWidget(),
              ],
            ),
            SizedBox(height: 20),
            Text('Pertandigan Akan Datang', style: TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              spacing: 10,
              children: [
                ContentWidget(),
                ContentWidget(),
                ContentWidget(),
                ContentWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
