import 'package:flutter/material.dart';
import 'package:gringsangan/presentation/widget/team_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              blurStyle: BlurStyle.normal,
              color: Colors.black12,
              offset: Offset(5, 5))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TeamWidget(
                  imagePath: 'assets/Persija.png',
                  imageWidth: 80,
                  imageHeight: 80,
                  text: 'Persija Jakarta',
                  color: Colors.white,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: TeamWidget(
                    imagePath: 'assets/vs.png',
                    imageWidth: 50,
                    imageHeight: 50,
                    text: 'Kick Off : 19.30',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TeamWidget(
                  imagePath: 'assets/Persita.png',
                  imageWidth: 80,
                  imageHeight: 80,
                  text: 'Persita',
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
