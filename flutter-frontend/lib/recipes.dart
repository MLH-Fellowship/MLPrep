import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'recipe_row_item.dart';

class Recipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final recipes = model.getRecipes();
        print(recipes);
        return CustomScrollView(
          semanticChildCount: recipes.length,
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Recipes'),
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
