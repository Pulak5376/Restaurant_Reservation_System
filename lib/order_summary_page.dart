import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderList;
  final double totalPrice;

  const OrderSummaryPage({
    super.key,
    required this.orderList,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order_Summary')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  var orderItem = orderList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(orderItem['name']),
                      subtitle: Text(
                        'Quantity: ${orderItem['quantity']} | Price: \$${orderItem['price']}',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Confirm order functionality (could be saved to Firestore, etc.)
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Order Placed!')));
                Navigator.pop(context); // Go back to the User Dashboard
              },
              child: const Text('Confirm_Order'),
            ),
          ],
        ),
      ),
    );
  }
}
