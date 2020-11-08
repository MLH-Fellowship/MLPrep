// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cupertino_store/model/recipe_repository.dart';
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
