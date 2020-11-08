import 'package:CookMe/model/recipe_repository.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'recipe.dart';
import 'recipe_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  // All the available products.

  List<Recipe> _availableRecipes;
  // The currently selected category of products.

  // The IDs and quantities of products currently in the cart.
  final _productsInCart = <int, int>{};

  Map<int, int> get productsInCart {
    return Map.from(_productsInCart);
  }

  List<Recipe> getRecipes() {
    if (_availableRecipes == null) {
      return [];
    } else {
      return List.from(_availableRecipes);
    }
  }

  void loadRecipes() {
    _availableRecipes = RecipeRepository.loadRecipes();
    notifyListeners();
  }
}
