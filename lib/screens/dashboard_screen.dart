// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_firestore_flutter_app/auth_helper.dart';
import 'package:iot_firestore_flutter_app/const/custom_styles.dart';
import 'package:iot_firestore_flutter_app/model/sensor.dart';
import 'package:iot_firestore_flutter_app/route/routing_constants.dart';
import 'package:iot_firestore_flutter_app/widgets/my_sensor_card.dart';
import 'package:flutter/material.dart';
import 'package:iot_firestore_flutter_app/const/custom_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  static String collectionName = 'Sensor';
  final sensorRef = FirebaseFirestore.instance
      .collection(collectionName)
      .withConverter<Sensor>(
        fromFirestore: (snapshots, _) => Sensor.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Sensor>>(
      stream: sensorRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MySensorCard(
                                value: data.docs.first.data().humidity,
                                unit: '%',
                                name: 'Humidity',
                                assetImage: const AssetImage(
                                  'assets/images/humidity_icon.png',
                                ),
                              ),
                              MySensorCard(
                                value: data.docs.first.data().temperature,
                                unit: '\'C',
                                name: 'Temperature',
                                assetImage: const AssetImage(
                                  'assets/images/temperature_icon.png',
                                ),
                              ),
                              MySensorCard(
                                value: data.docs.first.data().voltage,
                                unit: 'V',
                                name: 'Voltage',
                                assetImage: const AssetImage(
                                  'assets/images/voltage_icon.png.png',
                                )
                              ),
                              //const SizedBox(
                              //  height: 20,
                             // ),
                              Card(
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                ),
                                shadowColor: Colors.grey,
                                elevation: 24,
                                color: kMainBG,child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:125,
                                child: Row(
                                children: [
                                Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Transform.scale(
                                              scale: 1.4,
                                              child:Switch(
                                                value: data.docs.first.data().isSwitchedOn,
                                                onChanged: (value) async {
                                                final DocumentReference docRef = data.docs.first.reference;
                                                await docRef.update({'switch': value});
                                                },   
                                                activeColor: Colors.yellow,  
                                                activeTrackColor: Colors.yellow,  
                                                inactiveThumbColor:  Colors.orange,  
                                                inactiveTrackColor: Colors.orange,
                                              ),
                                            ),
                                            Text('manual switch',
                                                style: kHeadline2.copyWith(color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ), 
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign out of app? ",
                        style: kBodyText,
                      ),
                      GestureDetector(
                        onTap: _signOut,
                        child: Text(
                          "Sign Out",
                          style: kBodyText.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    ));
  }

  _signOut() async {
    await AuthHelper.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, SplashScreenRoute, (Route<dynamic> route) => false);
  }
}
