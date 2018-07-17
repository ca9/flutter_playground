import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_shopping_cart/list/shopping_list_item.dart';
import 'package:flutter_shopping_cart/model/AppState.dart';
import 'package:flutter_shopping_cart/model/CartItem.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<CartItem>>(
      // https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65#f4b5
      // we return a function that takes the (store) and returns
      // what should be the widget specific state (here, "list") to the builder
      // the converter below maps to what is made available to this widget
      converter: (store) => store.state.cartItems,
      // ...which is the list of cart items. it accordingly builds out
      // stuff below
      builder: (context, list) {
        return new ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, position) =>
                new ShoppingListItem(list[position]));
      },
    );
  }
}
