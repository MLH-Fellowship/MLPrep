import 'package:flutter/foundation.dart';

class Recipe {
  const Recipe({
    @required this.name,
    @required this.url,
    @required this.img,
    @required this.cuisine,
    @required this.ingredients,
  });
    // : assert(name != null, 'name must not be null'),
    //     assert(url != null, 'url must not be null'),
    //     assert(img != null, 'img must not be null'),
    //     assert(name != null, 'name must not be null'),
    //     assert(cuisine != null, 'cuisine must not be null'),
    //     assert(ingredients != null, 'ingredients must not be null');

  final String name;
  final String url;
  final String img;
  final String cuisine;
  final String ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print(json);
    return Recipe(
      name: json['name'],
      url: json['url'],
      img: json['img'],
      cuisine: json['cuisine'],
      ingredients: json['ingredients'].join(",")
    );
  }
}
