import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:agenda/Models/Attivita.dart';
import 'package:agenda/Models/AttivitaController.dart';
import 'package:agenda/Widgets/Errore.dart';
import 'package:agenda/Widgets/BottoneSalva.dart';
import 'package:agenda/Widgets/NavBar.dart';
import 'package:flutter/services.dart';

class ModificaAttivitaPage extends StatefulWidget {
  final Attivita attivita;

  ModificaAttivitaPage({super.key, required this.attivita});

  @override
  State<ModificaAttivitaPage> createState() => _ModificaAttivitaPageState();
}

class _ModificaAttivitaPageState extends State<ModificaAttivitaPage> {
  Attivita get attivita => widget.attivita;

  late final TextEditingController titoloController;
  late final TextEditingController descrizioneController;
  late final TextEditingController luogoController;
  late final TextEditingController dataController;
  late final TextEditingController durataController;

  static const Color bg = Color(0xFFF7F7F7);
  static const Color textDark = Color(0xFF1C1C28);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color greyBox = Color(0xFFEFEFEF);
  static const Color purple = Color(0xFF66518D);

  Map<String, List<String>> errori = {
    'titolo': [],
    'descrizione': [],
    'luogo': [],
    'data': [],
    'durata': [],
  };

  @override
  void initState() {
    super.initState();

    titoloController = TextEditingController(text: attivita.titolo);
    descrizioneController = TextEditingController(text: attivita.descrizione);
    luogoController = TextEditingController(text: attivita.luogo);
    dataController = TextEditingController(
      text: "${DateFormat('yyyy-MM-dd HH:mm').format(attivita.data)}",
    ); //ritorno il formato che voglio
    durataController = TextEditingController(text: '${attivita.durata}');

    //svuota tutti gli errori all'avvio della pagina
    for (var lista in errori.values) {
      lista.clear();
    }
  }

  @override
  void dispose() {
    titoloController.dispose();
    descrizioneController.dispose();
    luogoController.dispose();
    dataController.dispose();
    durataController.dispose();
    super.dispose();
  }

  void salvaModifiche() {
    // Svuota gli errori precedenti
    for (var lista in errori.values) {
      lista.clear();
    }

    // Validazione
    String? titolo = AttivitaController.controllaTitolo(titoloController.text);
    String? descrizione = AttivitaController.controllaDescrizione(
      descrizioneController.text,
    );
    String? luogo = AttivitaController.controllaLuogo(luogoController.text);
    String? data = AttivitaController.controllaData(dataController.text);
    String? durata = AttivitaController.controllaDurata(durataController.text);

    // Aggiunge gli errori alla Map
    if (titolo != null) errori['titolo']!.add(titolo);
    if (descrizione != null) errori['descrizione']!.add(descrizione);
    if (luogo != null) errori['luogo']!.add(luogo);
    if (data != null) errori['data']!.add(data);
    if (durata != null) errori['durata']!.add(durata);

    // Se ci sono errori, aggiorna la grafica e interrompe
    if (errori.values.any((lista) => lista.isNotEmpty)) {
      setState(() {});
      return;
    }

    // Aggiorna l'attività
    attivita.titolo = titoloController.text.trim();
    attivita.descrizione = descrizioneController.text;
    attivita.luogo = luogoController.text;
    attivita.data = DateFormat('yyyy-MM-dd HH:mm')
        .parseStrict(dataController.text);
    attivita.durata = int.tryParse(durataController.text) ?? 0;

    // Torna alla pagina precedente
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    const Text(
                      'Modifica attività',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Modifica le informazioni del tuo evento',
                      style: TextStyle(fontSize: 12, color: textGrey),
                    ),

                    const SizedBox(height: 20),

                    // FORM
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label(
                            'Titolo',
                            '${titoloController.text.length}/50',
                          ),
                          _field(
                            titoloController,
                            placeholder: "Titolo",
                            maxLength: 50,
                          ),
                          mostraErrori(errori['titolo']!),

                          const SizedBox(height: 18),

                          _label(
                            'Descrizione',
                            '${descrizioneController.text.length}/150',
                          ),
                          _field(
                            descrizioneController,
                            placeholder: "Descrizione",
                            height: 85,
                            maxLength: 150,
                          ),
                          mostraErrori(errori['descrizione']!),

                          const SizedBox(height: 18),

                          _label('Luogo', '${luogoController.text.length}/100'),
                          _field(
                            luogoController,
                            placeholder: "Luogo",
                            maxLength: 100,
                          ),

                          const SizedBox(height: 18),

                          _label('Data e ora di inizio'),
                          _field(
                            dataController,
                            placeholder:
                                "Inizio dell'attività (almeno il giorno)",
                          ),
                          mostraErrori(errori['data']!),

                          const SizedBox(height: 18),

                          _label('Durata'),
                          _field(
                            durataController,
                            placeholder: "Durata (opzionale)",
                          ),
                          mostraErrori(errori['durata']!),

                          const SizedBox(height: 20),

                          _label('Colore attività'),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              _color(attivita.colore, selected: true),
                              _color('#6C63C7'),
                              _color('#4C9A85'),
                              _color('#E2A64A'),
                              _color('#5C83B7'),
                              _color('#555555'),
                              _color('#D96B65'),

                              Container(
                                width: 27,
                                height: 27,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFEFEF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Color(0xFF1C1C28),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          BottoneSalva(onPressed: salvaModifiche),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // WHISPER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFEAEAEA)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EAF8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.mic_none,
                              color: purple,
                              size: 25,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Parla per modificare',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: textDark,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Descrivi le modifiche a voce',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const BottomBar(),
          ],
        ),
      ),
    );
  }

  // LABEL
  Widget _label(String testo, [String? limite]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              testo,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
          ),
          if (limite != null)
            Text(limite, style: const TextStyle(fontSize: 10, color: textGrey)),
        ],
      ),
    );
  }

  // CAMPO GRAFICO
  Widget _field(
    TextEditingController controller, {
    String? placeholder,
    double height = 43,
    int? maxLength,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,

        // Limite massimo di caratteri
        inputFormatters: [
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],

        onChanged: (valore) {
          setState(() {});
        },

        maxLines: height > 43 ? null : 1,
        expands: height > 43,

        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFAAAAAA)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
          ),
        ),

        style: const TextStyle(fontSize: 12, color: textDark),
      ),
    );
  }

  // COLORE
  Widget _color(String hex, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          color: Color(int.parse(hex.replaceFirst('#', '0xFF'))),
          shape: BoxShape.circle,
          border: selected ? Border.all(color: textDark, width: 2) : null,
        ),
      ),
    );
  }
}
