import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot_firestore_flutter_app/const/custom_styles.dart';
import 'package:iot_firestore_flutter_app/route/routing_constants.dart';
import 'package:flutter/material.dart';

import '../auth_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: AuthHelper.initializeFirebase(context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User? user = AuthHelper.currentUser();
          if (user != null) {
            Future.delayed(Duration.zero, () async {
              Navigator.pushNamedAndRemoveUntil(context, DashboardScreenRoute,
                  (Route<dynamic> route) => false);
            });
          } else {
            return _getScreen(context);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  _getScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                const Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/background.png',
                    ),
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "external ventilation system",
                  style: kHeadline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    "Faculty of Technology, University of Ruhuna",
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black12,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      SignInScreenRoute, (Route<dynamic> route) => false);
                },
                child: Text(
                  'GET STARTED',
                  style: kButtonText.copyWith(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
