import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/recipe.dart';
import 'styles.dart';
import 'recipe_details.dart';

class RecipeRowItem extends StatelessWidget {
  const RecipeRowItem({
    this.index,
    this.recipe,
    this.lastItem,
  });

  final Recipe recipe;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: GestureDetector(
          onTap: () { 
             Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeDetails(url: recipe.url)
                    )
              );
          },
          child: Row(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    recipe.img,
                    fit: BoxFit.cover,
                    width: 76,
                    height: 76,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        recipe.name,
                        style: Styles.productRowItemName,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        recipe.ingredients,
                        style: Styles.productRowItemPrice,
                      )
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  final model = Provider.of<AppStateModel>(context, listen: false);
                },
                child: const Icon(
                  CupertinoIcons.heart,
                  semanticLabel: 'Add',
                ),
              ),
            ],
          ),
      )
    );

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }
}
