import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CartPageContent extends StatefulWidget {
  @override
  _CartPageContentState createState() => _CartPageContentState();
}

class _CartPageContentState extends State<CartPageContent> {
  List<int> quantities = [1, 1, 1];

  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildCartItem("Book 1", 29.90, 0),
          SizedBox(height: 16),
          buildCartItem("Book 2", 39.90, 1),
          SizedBox(height: 16),
          buildCartItem("Book 3", 19.90, 2),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(315, 66)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                  ),
                ),
                onPressed: () {
                  // Action for the "Fechar Pedido" button
                },
                child: Text("Close Order"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(String bookName, double price, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'R\$ ${(price * quantities[index]).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              IconButton(
                onPressed: () => decrementQuantity(index),
                icon: Icon(Icons.arrow_downward),
              ),
              Text(
                quantities[index].toString(),
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                onPressed: () => incrementQuantity(index),
                icon: Icon(Icons.arrow_upward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
