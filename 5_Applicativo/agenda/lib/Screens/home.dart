import 'package:flutter/material.dart';

//import '../Models/*';
//import '../Services/*';
//import '../Widgets/*';

/// Schermata principale: unisce interfaccia e gestione degli eventi.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 100),
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text('9 Settembre 2025'),
        backgroundColor: Color.fromARGB(75, 64, 226, 150),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text("Visualizza eventi - giorno"),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nuova attività',
                      hintText: 'Es. Studiare Dart',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Aggiungi',
                  onPressed: () => "ciao",
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
