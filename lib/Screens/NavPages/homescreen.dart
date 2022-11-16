// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mine/Models/model1.dart';
import 'package:mine/Models/getapi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipes> recipelist = [];
  getRecipeData() async {
    recipelist = await ApiServices().getData();
    print(recipelist.length);
  }

  @override
  void initState() {
    getRecipeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getRecipeData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("LOADING");
              } else {
                return ListView.builder(
                    itemCount: recipelist.length,
                    itemBuilder: (BuildContext context, int index) {
                      Recipes recipe = recipelist[index];
                      print(recipe.title);
                      return RecipeWidget(
                        title: recipe.title!,
                        imgUrl: recipe.image!,
                        isVeg: recipe.vegetarian,
                      );
                    });
              }
            },
          ),
        )
      ]),
    );
  }
}

class RecipeWidget extends StatelessWidget {
  final String title;
  final String imgUrl;
  final bool isVeg;
  const RecipeWidget(
      {Key? key,
      required this.title,
      required this.imgUrl,
      required this.isVeg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imgUrl,
                  height: 125,
                  width: 125,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              isVeg
                  ? Text("Vegetarian", style: TextStyle(color: Colors.green))
                  : Text("Non-Vegetarian", style: TextStyle(color: Colors.red))
            ],
          ))
        ],
      ),
    );
  }
}
/*return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Recipes",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      );*/