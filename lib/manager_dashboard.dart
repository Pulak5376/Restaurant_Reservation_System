import 'package:flutter/material.dart';
import 'main.dart'; // For UserDataStore

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final List<Map<String, dynamic>> _foodList = [
    {'id': '1', 'name': 'Pizza', 'price': 12.99},
    {'id': '2', 'name': 'Burger', 'price': 8.99},
    {'id': '3', 'name': 'Pasta', 'price': 10.99},
    {'id': '4', 'name': 'Sub_Burger', 'price': 15.00},
  ];

  void _addFoodItem() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Food Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _foodList.add({
                    'id': DateTime.now().toString(),
                    'name': nameController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editFoodItem(String foodId, String currentName, double currentPrice) {
    TextEditingController nameController = TextEditingController(
      text: currentName,
    );
    TextEditingController priceController = TextEditingController(
      text: currentPrice.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Food Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final index = _foodList.indexWhere(
                    (food) => food['id'] == foodId,
                  );
                  if (index != -1) {
                    _foodList[index]['name'] = nameController.text;
                    _foodList[index]['price'] =
                        double.tryParse(priceController.text) ?? currentPrice;
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _removeFoodItem(String foodId) {
    setState(() {
      _foodList.removeWhere((food) => food['id'] == foodId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final managerEmail =
        UserDataStore.getUserData('email') ?? 'manager@example.com';
    final managerName = UserDataStore.getUserData('name') ?? 'Manager';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addFoodItem),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(managerName),
              accountEmail: Text(managerEmail),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                UserDataStore.clearUserData();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _foodList.length,
          itemBuilder: (context, index) {
            var food = _foodList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(food['name']),
                subtitle: Text('Price: \$${food['price']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed:
                          () => _editFoodItem(
                            food['id'],
                            food['name'],
                            food['price'],
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeFoodItem(food['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
