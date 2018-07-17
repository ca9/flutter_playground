import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_shopping_cart/model/AppState.dart';
import 'package:flutter_shopping_cart/model/CartItem.dart';
import 'package:flutter_shopping_cart/redux/actions.dart';

class AddItemDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnAddCallback>(
        converter: (store) {
          // https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65#f4b5
          // this function below is returned to the builder below
          // "itemName" below is a parameter name. This was originally
          // return (itemName) => store.dispatch...
          // which does not explicitly call out the types
      void Function(String) callback = (itemName) =>
          store.dispatch(AddItemAction(CartItem(itemName, false)));
      return callback;
    }, builder: (context, callback) {
          // the builder knows ahead of time what "could" be added.
          // the "callback" is the method returned from the converter.
          // that in some sense makes the store "accessible"
      return new AddItemDialogWidget(callback);
    });
  }
}

class AddItemDialogWidget extends StatefulWidget {
  final OnAddCallback callback;

  AddItemDialogWidget(this.callback);

  @override
  State<StatefulWidget> createState() =>
      new AddItemDialogWidgetState(callback);
}

class AddItemDialogWidgetState extends State<AddItemDialogWidget> {
  String itemName;

  final OnAddCallback callback;

  AddItemDialogWidgetState(this.callback);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Item name', hintText: 'eg. Red Apples'),
              onChanged: _handleTextChanged,
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            }),
        new FlatButton(
            child: const Text('ADD'),
            onPressed: () {
              Navigator.pop(context);
              callback(itemName);
            })
      ],
    );
  }

  _handleTextChanged(String newItemName) {
    setState(() {
      itemName = newItemName;
    });
  }
}

typedef OnAddCallback = Function(String itemName);
