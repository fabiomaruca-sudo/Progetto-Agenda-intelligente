import 'dart:collection';
import 'package:intl/intl.dart';

import 'package:agenda/Services/DataGiorno.dart';

class Attivita {
  // Lista di tutte le attività e contatore per gli id (appartengono alla classe)
  static final List<Attivita> _lista = []; //da inizializzare vuota

  static List<Attivita> get lista => _lista;

  // Dati di esempio, da chiamare una volta (es. in main)
static void caricaDati() {
  _lista.clear();

  Attivita(
    titolo: 'Scuola',
    data: DateTime(2025, 9, 9, 8, 0),
    descrizione: 'Lezioni scolastiche',
    luogo: 'SAM Trevano',
    durata: 480,
    colore: '#2196F3',
  );

  Attivita(
    titolo: 'Dentista',
    data: DateTime(2025, 9, 9, 14, 0),
    descrizione: 'Controllo dentale',
    luogo: 'Studio Rossi',
    durata: 60,
    colore: '#4CAF50',
  );

  Attivita(
    titolo: 'Palestra',
    data: DateTime(2025, 9, 9, 17, 30),
    descrizione: 'Allenamento',
    luogo: 'Palestra comunale',
    durata: 60,
    colore: '#FF9800',
  );

  Attivita(
    titolo: 'Spesa',
    data: DateTime(2025, 9, 9, 18, 30),
    descrizione: 'Fare la spesa settimanale',
    luogo: 'Coop',
    durata: 45,
    colore: '#9C27B0',
  );

  Attivita(
    titolo: 'Riunione',
    data: DateTime(2025, 9, 9, 10, 0),
    descrizione: 'Riunione di progetto',
    luogo: 'Scuola',
    durata: 30,
    colore: '#F44336',
  );

  Attivita(
    titolo: 'Scuola',
    data: DateTime(2025, 9, 10, 8, 0),
    descrizione: 'Lezioni scolastiche',
    luogo: 'SAM Trevano',
    durata: 480,
    colore: '#2196F3',
  );

  Attivita(
    titolo: 'Lezione di piano',
    data: DateTime(2025, 9, 10, 16, 0),
    descrizione: 'Lezione individuale',
    luogo: 'Scuola di musica',
    durata: 60,
    colore: '#E91E63',
  );

  Attivita(
    titolo: 'Cena',
    data: DateTime(2025, 9, 10, 19, 30),
    descrizione: 'Cena con amici',
    luogo: 'Casa',
    durata: 90,
    colore: '#FF5722',
  );

  Attivita(
    titolo: 'Compleanno',
    data: DateTime(2025, 9, 12, 20, 0),
    descrizione: 'Festa di compleanno',
    luogo: 'Casa di Marco',
    durata: 180,
    colore: '#FFEB3B',
  );

  Attivita(
    titolo: 'Visita medica',
    data: DateTime(2025, 10, 1, 9, 30),
    descrizione: 'Controllo medico',
    luogo: 'Ospedale',
    durata: 45,
    colore: '#00BCD4',
  );
}

  static int _ultimoId = 0;

  static int _generaId() => ++_ultimoId;

  // Campi privati
  final int _id;
  String _titolo;
  String _descrizione;
  String _luogo;
  DateTime _data;
  int _durata;
  String _colore;

  // Costruttore
  Attivita({
    required String titolo,
    required DateTime data,
    String descrizione = '',
    String luogo = '',
    int durata = 0,
    String colore = '#000000',
  }) : _id = _generaId(),
       _titolo = titolo,
       _data = data,
       _descrizione = descrizione,
       _luogo = luogo,
       _durata = durata,
       _colore = colore {
    _lista.add(this);
  }

  // Costruttore alternativo: la data arriva come stringa
  factory Attivita.daStringa({
    required String titolo,
    required String data,
    String descrizione = '',
    String luogo = '',
    int durata = 0,
    String colore = '#000000',
  }) {
    final parsed = DateTime.parse(data);
    return Attivita(
      titolo: titolo,
      data: parsed,
      descrizione: descrizione,
      luogo: luogo,
      durata: durata,
      colore: colore,
    );
  }

  // Getter e setter
  int get id => _id; // solo lettura: l'id non si cambia

  String get titolo => _titolo;
  set titolo(String valore) => _titolo = valore;

  String get descrizione => _descrizione;
  set descrizione(String valore) => _descrizione = valore;

  String get luogo => _luogo;
  set luogo(String valore) => _luogo = valore;

  DateTime get data => _data;
  set data(DateTime valore) => _data = valore;

  int get durata => _durata;
  set durata(int valore) {
    if (valore < 0) {
      throw ArgumentError('La durata non può essere negativa');
    }
    _durata = valore;
  }

  String get colore => _colore;
  set colore(String valore) => _colore = valore;

DataGiorno orarioFine() {
  DataGiorno fine = DataGiorno(_data.add(Duration(minutes: durata)));
  return fine;
}

  String get oraInizio => DateFormat('HH:mm').format(_data);
  String get oraFine => DateFormat('HH:mm').format(orarioFine().data);
}
