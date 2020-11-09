import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IngredientsList extends StatefulWidget {
  List<String> ingredients;

  IngredientsList({Key key, @required this.ingredients}) : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  TextEditingController nameController = TextEditingController();
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

    void addItemToList() {
      setState(() {
        widget.ingredients.insert(0, nameController.text);
      });
    }

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
      body: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.ingredients[index];
                  return Dismissible(
                    key: Key(item),
                    direction: DismissDirection.startToEnd,
                    child: ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          setState(() {
                            widget.ingredients.removeAt(index);
                          });
                        },
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        widget.ingredients.removeAt(index);
                      });
                    },
                  );
                })),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ingredient',
                    ),
                    controller: nameController,
                    onSubmitted: (text) {},
                  ),
                ),
              ),
              FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      addItemToList();
                    });
                  })
            ]))
      ]),
    );
  }
}
