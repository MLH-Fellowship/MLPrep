import 'recipe.dart';

class RecipeRepository {
  static const _allRecipes = <Recipe>[
    Recipe(
        name: 'Chicken Tikki',
        cuisine: 'Indian',
        img:
            'https://www.daringgourmet.com/wp-content/uploads/2019/12/Chicken-Tikka-Masala-10-square.jpg',
        ingredients: 'lemon, chicken, cheese, rice',
        url: 'google.com'),
    Recipe(
        name: 'Chicken Briyani',
        cuisine: 'Indian',
        img:
            'https://www.kannammacooks.com/wp-content/uploads/Chicken-Biryani-Recipe-Tamil-Style-Easy-Bachelor-friendly-recipe-1-31.jpg',
        ingredients: 'Chicken, Rice, Tomato, zest',
        url: 'google.com'),
    Recipe(
        name: 'Chicken Tacos',
        cuisine: 'Mexican',
        img:
            'https://s23209.pcdn.co/wp-content/uploads/2019/08/Easy-Chicken-TacosIMG_9890.jpg',
        ingredients: 'Chicken, lemon, tortilla',
        url: 'www.youtube.com'),
  ];

  static List<Recipe> loadRecipes() {
    return _allRecipes;
  }
}
