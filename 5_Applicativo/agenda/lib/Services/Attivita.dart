class Attivita {
  // Lista di tutte le attività e contatore per gli id (appartengono alla classe)
  final List<Attivita> attivita = [
    // 5 attività il 9 settembre
    Attivita(titolo: 'Scuola', data: DateTime(2025, 9, 9), durata: 480),
    Attivita(
      titolo: 'Dentista',
      data: DateTime(2025, 9, 9),
      luogo: 'Studio Rossi',
    ),
    Attivita(titolo: 'Palestra', data: DateTime(2025, 9, 9), durata: 60),
    Attivita(titolo: 'Spesa', data: DateTime(2025, 9, 9)),
    Attivita(titolo: 'Riunione', data: DateTime(2025, 9, 9), durata: 30),

    // 3 attività il 10 settembre
    Attivita(titolo: 'Scuola', data: DateTime(2025, 9, 10), durata: 480),
    Attivita(
      titolo: 'Lezione di piano',
      data: DateTime(2025, 9, 10),
      durata: 60,
    ),
    Attivita(titolo: 'Cena', data: DateTime(2025, 9, 10)),

    // 2 attività in date diverse
    Attivita(titolo: 'Compleanno', data: DateTime(2025, 9, 12)),
    Attivita(
      titolo: 'Visita medica',
      data: DateTime(2025, 10, 1),
      luogo: 'Ospedale',
    ),
  ];

  static final List<Attivita> _lista = [];
  static int _ultimoId = 0;

  static List<Attivita> get tutte => List.unmodifiable(_lista);

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
}
