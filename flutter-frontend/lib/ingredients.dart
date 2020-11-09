import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IngredientsList extends StatefulWidget {
  List<String> ingredients;

  IngredientsList({Key key, @required this.ingredients}) : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    
    widget.ingredients.forEach((item) {
      children.add(
        new Row(
          children: <Widget>[
            new Text(item.toString()),
            new SizedBox(width: 50.0),
            new Icon(Icons.delete),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("List of Ingredients"),
        actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          onPressed: () async {
            var url = "http://127.0.0.1:5000/${widget.ingredients.join(',')}";
            //var response = await http.get(url);
          },
          child: Text("Confirm"),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        ),
      ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
        children: children,
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              
            })
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}