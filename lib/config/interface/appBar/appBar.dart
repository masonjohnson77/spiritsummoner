import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:spirit_summoner/config/interface/appBar/appBarBarrel.dart';

class AppBarPane extends StatelessWidget {
  const AppBarPane({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.01),
                Colors.white.withOpacity(0.1),
              ],
            ),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlayerIcon(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlayerInfo(),
                        PlayerEXP(),
                      ],
                    ),
                  ),
                ],
              ),
              PlayerCurrency(),
            ],
          ),
        ),
      ),
    );
  }
}