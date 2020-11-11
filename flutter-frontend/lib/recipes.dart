import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'recipe_row_item.dart';
import 'model/recipe.dart';

class Recipes extends StatefulWidget {
  List<Recipe> recipes;

  Recipes({Key key, @required this.recipes}) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

@override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          semanticChildCount: widget.recipes.length,
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
                    if (index < widget.recipes.length) {
                      return RecipeRowItem(
                          index: index,
                          recipe: widget.recipes[index],
                          lastItem: index == widget.recipes.length - 1);
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

// class Recipes extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppStateModel>(
//       builder: (context, model, child) {
//         final recipes = model.getRecipes();
//         print("In Recipes: " + recipes[0].name);
//         return CustomScrollView(
//           semanticChildCount: recipes.length,
//           slivers: <Widget>[
//             const CupertinoSliverNavigationBar(
//               largeTitle: Text('Recipes'),
//             ),
//             SliverSafeArea(
//               top: false,
//               minimum: const EdgeInsets.only(top: 8),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     if (index < recipes.length) {
//                       return RecipeRowItem(
//                           index: index,
//                           recipe: recipes[index],
//                           lastItem: index == recipes.length - 1);
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
