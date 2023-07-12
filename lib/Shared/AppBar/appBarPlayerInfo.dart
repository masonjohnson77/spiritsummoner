import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spirit_summoner/Services/auth.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(AuthService().uid)
            .collection('summoner-info')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No stats found.'),
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.075,
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String playerLevel = data['level'] ?? '';
                String playerName = data['username'] ?? '';
                String playerTitle = data['title'] ?? '';
                String playerReputation = data['reputation'] ?? '';

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerName,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 1.0,
                            offset: Offset(
                              1,
                              1,
                            ),
                          )
                        ],
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Level " +
                          playerLevel +
                          '   |   ' +
                          playerTitle +
                          '   |   ' +
                          playerReputation,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 1.0,
                            offset: Offset(
                              1,
                              1,
                            ),
                          )
                        ],
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        });
  }
}
