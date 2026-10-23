import 'package:flutter/material.dart';
import 'package:agenda/Widgets/NavBar.dart';
import 'package:agenda/Services/DataGiorno.dart';
import 'package:agenda/Services/Attivita.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AttivitaGiornoPage(),
  ),
);

void addAttivita() {
  return;
}

void render() {
  final Map<DateTime, int> perData = {};
  for (final a in Attivita.tutte) {
    final giorno = DateTime(a.data.year, a.data.month, a.data.day);
    perData[giorno] = (perData[giorno] ?? 0) + 1;
  }
}

class AttivitaGiornoPage extends StatelessWidget {
  const AttivitaGiornoPage({super.key});

  static const Color bg = Color(0xFFF7F7F7);
  static const Color textDark = Color(0xFF1C1C28);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color greyBox = Color(0xFFEFEFEF);

  @override
  Widget build(BuildContext context, Attivita attivita) {
    final date = DataGiorno.oggi();

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(date),
                    const SizedBox(height: 16),
                    _buildDateCard(date),
                    const SizedBox(height: 24),
                    const Text(
                      'Attività',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ActivityCard(
                      title: 'Scuola',
                      time: '08:20 – 15:45',
                      data: date,
                    ),
                  ],
                ),
              ),
            ),
            _buildFooterActions(), // anche questo resta fisso
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(), // fisso in basso
    );
  }

  // Titolo + sottotitolo + pulsante dropdown
  Widget _buildHeader(DataGiorno date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.nomeGiorno,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: textDark,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Visualizza eventi · giorno',
                style: TextStyle(fontSize: 12, color: textGrey),
              ),
            ],
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFFFCEFF5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Color(0xFFB0306A),
          ),
        ),
      ],
    );
  }

  // Card con giorno, data e badge eventi
  Widget _buildDateCard(DataGiorno date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date.nomeGiorno,
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 0.5,
                    color: textGrey,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date.dataEstesa,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: greyBox,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '3 eventi',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // "vedi settimana" + pulsante +
  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: greyBox,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'vedi settimana',
              style: TextStyle(fontSize: 13, color: textDark),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              addAttivita();
            },
            icon: const Icon(Icons.add, size: 28, color: textDark),
          ),
        ],
      ),
    );
  }
}

// Card della singola attività
class ActivityCard extends StatelessWidget {
  final String title;
  final String time;
  final DataGiorno data;

  const ActivityCard({
    super.key,
    required this.title,
    required this.time,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AttivitaGiornoPage.textDark,
                    ),
                  ),
                ),
                Text(
                  data.nomeMese,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AttivitaGiornoPage.textGrey,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AttivitaGiornoPage.greyBox,
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Modifica',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AttivitaGiornoPage.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
