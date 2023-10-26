import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class IndexList extends StatelessWidget {
  const IndexList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('index').get(),
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
            child: Text('No spirits found.'),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.425,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            padding: EdgeInsets.only(top: 8.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String spiritID = document.id;
              String spiritName = data['name'] ?? '';
              String spiritCore = data['core-type'] ?? '';
              String spiritCategory = data['category'] ?? '';
              double spiritDropRate =
                  (data['drop-rate'].toDouble() * 100) ?? 100.0;
              Map<String, dynamic> baseStats =
                  data['base-stats'] as Map<String, dynamic>;
              int baseATK = baseStats['atk'] ?? 1.0;
              int baseDEF = baseStats['def'] ?? 1.0;
              int baseMGK = baseStats['mgk'] ?? 1.0;
              int baseMDF = baseStats['mdf'] ?? 1.0;
              int baseSPD = baseStats['spd'] ?? 1.0;
              int baseINT = baseStats['int'] ?? 1.0;
              Map<String, dynamic> bonusStats =
                  data['bonus-stats'] as Map<String, dynamic>;
              double bonusATK = bonusStats['atk'].toDouble() ?? 1.0;
              double bonusDEF = bonusStats['def'].toDouble() ?? 1.0;
              double bonusMGK = bonusStats['mgk'].toDouble() ?? 1.0;
              double bonusMDF = bonusStats['mdf'].toDouble() ?? 1.0;
              double bonusSPD = bonusStats['spd'].toDouble() ?? 1.0;
              double bonusINT = bonusStats['int'].toDouble() ?? 1.0;
              List<dynamic> moves = data['moves'] as List<dynamic>;
              return Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    print(spiritName);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.425,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            /*image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              image: AssetImage('assets/Backgrounds/Shop' +
                                  itemName +
                                  '.png'),
                            ),*/
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.8),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
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
                              width: 1.4,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        alignment: Alignment.center,
                                        image: AssetImage('assets/Spirits/' +
                                            spiritID +
                                            '_' +
                                            spiritName +
                                            '.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            alignment: Alignment.center,
                                            image: AssetImage(
                                                'assets/Icons/type' +
                                                    spiritCore +
                                                    '.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          spiritName,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        spiritCategory + ' | ' + spiritCore,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Stats',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'ATK+: $baseATK * $bonusATK',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'DEF+: $baseDEF * $bonusDEF',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'MGK+: $baseMGK * $bonusMGK',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'MDF+: $baseMDF * $bonusMDF',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'SPD+: $baseSPD * $bonusSPD',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                        top: 8.0,
                                        right: 16.0,
                                        bottom: 16.0,
                                      ),
                                      child: Container(
                                        child: Text(
                                          'INT+: $baseINT * $bonusINT',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Drop Rate: $spiritDropRate%',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Move List',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          for (var moves in document['moves'])
                                            Text(
                                              moves.toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}