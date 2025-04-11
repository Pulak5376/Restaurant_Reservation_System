import 'package:flutter/material.dart';
import 'order_summary_page.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final List<Map<String, dynamic>> _foodList = [
    {'id': '1', 'name': 'Pizza', 'price': 12.99},
    {'id': '2', 'name': 'Burger', 'price': 8.99},
    {'id': '3', 'name': 'Pasta', 'price': 10.99},
  ];

  final List<Map<String, dynamic>> _orderList = [];

  void _addToOrder(String foodId, String name, double price) {
    setState(() {
      _orderList.add({
        'foodId': foodId,
        'name': name,
        'price': price,
        'quantity': 1,
      });
    });
  }

  void _placeOrder() {
    double totalPrice = _orderList.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                OrderSummaryPage(orderList: _orderList, totalPrice: totalPrice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _foodList.length,
                itemBuilder: (context, index) {
                  var food = _foodList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(food['name']),
                      subtitle: Text('Price: \$${food['price']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed:
                            () => _addToOrder(
                              food['id'],
                              food['name'],
                              food['price'],
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _orderList.isEmpty ? null : _placeOrder,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
