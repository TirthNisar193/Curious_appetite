// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' show Html;

// ignore: must_be_immutable
class RecipeInfo extends StatelessWidget {
  String summary;
  String title;
  String image;
  int time;
  bool isVeg;
  RecipeInfo(
      {Key? key,
      required this.title,
      required this.image,
      required this.time,
      required this.isVeg,
      required this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Information"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.network(image),
          Text(
            title,
            style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
          ),
          Html(
            data: summary,
          )
        ],
      )),
    ));
  }
}
