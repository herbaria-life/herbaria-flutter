import 'package:flutter/material.dart';

import '../settings.dart' as Herbaria;

// HomePage
class HomePage extends StatelessWidget {
  Future<void> logout() {
    Herbaria.logger.d("Button pushed!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            ElevatedButton(child: Text("Home Page!"), onPressed: logout),
          ],
        )
    );
  }
}
