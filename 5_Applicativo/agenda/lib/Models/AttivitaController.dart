import 'package:intl/intl.dart';

class AttivitaController {
  static String? controllaTitolo(String titolo) {
    if (titolo.trim().isEmpty) {
      return 'Il titolo è obbligatorio';
    }

    if (titolo.length > 50) {
      return 'Massimo 50 caratteri';
    }

    return null;
  }

  static String? controllaDescrizione(String descrizione) {
    if (descrizione.length > 150) {
      return 'Massimo 150 caratteri';
    }

    return null;
  }

  static String? controllaLuogo(String luogo) {
    if (luogo.length > 100) {
      return 'Massimo 100 caratteri';
    }

    return null;
  }

  static String? controllaData(String data) {
    try {
      DateTime risultato = DateFormat('yyyy-MM-dd HH:mm').parseStrict(data);

      return null;
    } catch (e) {
      return 'Data non valida';
    }
  }

  static String? controllaDurata(String durata) {
    if (durata.isEmpty) {
      return null; // Durata opzionale
    }

    if (int.tryParse(durata) == null) {
      return 'Valore numerico richiesto';
    }

    if (int.parse(durata) <= 0) {
      return 'La durata deve essere maggiore di zero';
    }

    return null;
  }
}
