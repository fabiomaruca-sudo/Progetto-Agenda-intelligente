class DataGiorno {
  final DateTime data;

  const DataGiorno(this.data);

  // Data di oggi (non può essere const, perché la data cambia)
  DataGiorno.oggi() : data = DateTime.now();
  DataGiorno.format(String date) : data = DateTime.parse(date);

  static const List<String> _mesi = [
    'Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
    'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre',
  ];

  // DateTime.weekday va da 1 (lunedì) a 7 (domenica)
  static const List<String> _giorni = [
    'Lunedì', 'Martedì', 'Mercoledì', 'Giovedì',
    'Venerdì', 'Sabato', 'Domenica',
  ];

  String get nomeMese => _mesi[data.month - 1];
  String get nomeGiorno => _giorni[data.weekday - 1];
  String get nomeGiornoMaiuscolo => nomeGiorno.toUpperCase();
  String get dataEstesa => '${data.day} $nomeMese ${data.year}';

  bool get isOggi {
    final now = DateTime.now();
    return data.year == now.year &&
        data.month == now.month &&
        data.day == now.day;
  }

  DataGiorno giornoDopo() =>
      DataGiorno(DateTime(data.year, data.month, data.day + 1));
  DataGiorno giornoPrima() =>
      DataGiorno(DateTime(data.year, data.month, data.day - 1));
}
