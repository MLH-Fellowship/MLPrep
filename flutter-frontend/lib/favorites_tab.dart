import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/recipe.dart';
import 'recipe_row_item.dart';

class FavoritesListTab extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('favorites');

  static void refresh(BuildContext context) {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FavoritesListTab()
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        List favoritesList = storage.getItem('favoritesList') ?? new List();
        List<Recipe> recipes = favoritesList.map((re) =>  Recipe.fromJson(re)).toList();
        return CustomScrollView(
          semanticChildCount: recipes.length,
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Favorites'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < recipes.length) {
                      return RecipeRowItem(
                          index: index,
                          recipe: recipes[index],
                          lastItem: index == recipes.length - 1);
                    }
                    return null;
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
