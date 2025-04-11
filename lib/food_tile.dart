import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final String foodId;
  final String foodName;
  final double foodPrice;
  final Function(String, String, double) onEdit;

  const FoodTile({
    Key? key,
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(foodName),
        subtitle: Text('Price: \$${foodPrice.toString()}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => onEdit(foodId, foodName, foodPrice),
        ),
      ),
    );
  }
}
