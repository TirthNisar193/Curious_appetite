import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'model1.dart';
class ApiServices {
  String? title;
  String? imgUrl;
  bool? isVeg;
  RecipesMain? recipesMain;
  List<Recipes>? _recipesList;


  getData() async {
    var responseBody;
    String apiKey = "7c553eb075924085af86feebde5a44b6";
    String baseUrl = "https://api.spoonacular.com/recipes";
    String url = '$baseUrl/random?number=10&apiKey=$apiKey';
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        //log(responseBody.toString());
        title = responseBody['recipes'][0]['title'];
        imgUrl = responseBody['recipes'][0]['image'];
        isVeg = responseBody['recipes'][0]['vegetarian'];
        debugPrint(title);
        // debugPrint(imgUrl);
        // debugPrint(isVeg.toString());
        var recipesMain = RecipesMain.fromJson(responseBody);
        _recipesList = recipesMain.recipes;
      } else {
        debugPrint(response.statusCode.toString());
      }
      return _recipesList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
