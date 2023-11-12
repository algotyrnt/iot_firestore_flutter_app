import 'package:flutter/material.dart';
import 'package:iot_firestore_flutter_app/const/custom_colors.dart';
import 'package:iot_firestore_flutter_app/const/custom_styles.dart';

class MySensorCard extends StatelessWidget {
  const MySensorCard(
      {Key? key,
      required this.value,
      required this.name,
      required this.assetImage,
      required this.unit})
      : super(key: key);

  final double value;
  final String name;
  final String unit;
  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadowColor: Colors.grey,
        elevation: 24,
        color: kMainBG,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 200,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 60,
                      image: assetImage,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(name, style: kBodyText.copyWith(color: Colors.black)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('$value$unit',
                        style: kHeadline.copyWith(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
