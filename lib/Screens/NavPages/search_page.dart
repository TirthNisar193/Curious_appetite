// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mine/Models/getapi.dart';
import 'package:mine/Models/model1.dart';

import 'homescreen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Recipes>? _recipeList;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getRecipeData(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: _recipeList!.length.compareTo(0),
            itemBuilder: (BuildContext context, int index) {
              Recipes recipe = _recipeList![index];
              return RecipeWidget(
                title: recipe.title!,
                imgUrl: recipe.image!,
                isVeg: recipe.vegetarian,
                summary: recipe.summary.toString(),
                time: recipe.cookingMinutes,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 5,
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Enter Recipe'));
  }

  getRecipeData({required String? query}) async {
    _recipeList = await ApiServices().getData()!;
  }
}
