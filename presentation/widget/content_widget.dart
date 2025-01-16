import 'package:flutter/material.dart';
import 'package:gringsangan/presentation/widget/team_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              blurStyle: BlurStyle.normal,
              color: Colors.black12,
              offset: Offset(5, 5))
        ],
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFffffff),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Minggu 11 Januari 2025",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TeamWidget(
                    imageHeight: 50,
                    imageWidth: 50,
                    imagePath: 'assets/Persija.png',
                    text: 'Persija'),
                const SizedBox(
                  height: 5.0,
                ),
                TeamWidget(
                  imageHeight: 25,
                  imageWidth: 25,
                  imagePath: 'assets/vs.png',
                  text: 'Kick Off : 19.30',
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TeamWidget(
                    imageHeight: 50,
                    imageWidth: 50,
                    imagePath: 'assets/Persita.png',
                    text: 'Persita'),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
