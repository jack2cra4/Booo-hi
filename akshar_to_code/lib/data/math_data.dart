import '../models/lesson.dart';

class MathData {
  static List<CountingItem> generateCounting() {
    final items = <CountingItem>[];
    const englishWords = [
      'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten',
      'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen',
      'Eighteen', 'Nineteen', 'Twenty',
    ];
    const hindiWords = [
      'एक', 'दो', 'तीन', 'चार', 'पाँच', 'छह', 'सात', 'आठ', 'नौ', 'दस',
      'ग्यारह', 'बारह', 'तेरह', 'चौदह', 'पंद्रह', 'सोलह', 'सत्रह',
      'अठारह', 'उन्नीस', 'बीस',
    ];
    const twentyHindi = [
      'इक्कीस', 'बाईस', 'तेईस', 'चौबीस', 'पच्चीस', 'छब्बीस', 'सत्ताईस',
      'अट्ठाईस', 'उनतीस', 'तीस', 'इकतीस', 'बत्तीस', 'तैंतीस', 'चौंतीस',
      'पैंतीस', 'छत्तीस', 'सैंतीस', 'अड़तीस', 'उनतालीस', 'चालीस',
    ];
    const fortyHindi = [
      'इकतालीस', 'बयालीस', 'तैंतालीस', 'चवालीस', 'पैंतालीस', 'छियालीस',
      'सैंतालीस', 'अड़तालीस', 'उनचास', 'पचास', 'इक्यावन', 'बावन',
      'तिरपन', 'चौवन', 'पचपन', 'छप्पन', 'सत्तावन', 'अट्ठावन', 'उनसठ', 'साठ',
    ];
    const sixtyHindi = [
      'इकसठ', 'बासठ', 'तिरसठ', 'चौंसठ', 'पैंसठ', 'छियासठ', 'सड़सठ',
      'अड़सठ', 'उनहत्तर', 'सत्तर', 'इकहत्तर', 'बहत्तर', 'तिहत्तर',
      'चौहत्तर', 'पचहत्तर', 'छिहत्तर', 'सतहत्तर', 'अठहत्तर', 'उन्यासी', 'अस्सी',
    ];
    const eightyHindi = [
      'इक्यासी', 'बयासी', 'तिरासी', 'चौरासी', 'पचासी', 'छियासी',
      'सत्तासी', 'अट्ठासी', 'नवासी', 'नब्बे', 'इक्यानवे', 'बानवे',
      'तिरानवे', 'चौरानवे', 'पचानवे', 'छियानवे', 'सत्तानवे',
      'अट्ठानवे', 'निन्यानवे', 'सौ',
    ];

    for (var i = 0; i < 100; i++) {
      final num = i + 1;
      String eng;
      String hin;
      if (num <= 20) {
        eng = englishWords[num - 1];
        hin = hindiWords[num - 1];
      } else if (num <= 40) {
        eng = _numToWords(num);
        hin = twentyHindi[num - 21];
      } else if (num <= 60) {
        eng = _numToWords(num);
        hin = fortyHindi[num - 41];
      } else if (num <= 80) {
        eng = _numToWords(num);
        hin = sixtyHindi[num - 61];
      } else {
        eng = _numToWords(num);
        hin = eightyHindi[num - 81];
      }
      items.add(CountingItem(number: num, english: eng, hindi: hin));
    }
    return items;
  }

  static String _numToWords(int n) {
    const ones = [
      '', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight',
      'Nine', 'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen',
      'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
    ];
    const tens = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];
    if (n < 20) return ones[n];
    if (n < 100) {
      return '${tens[n ~/ 10]} ${ones[n % 10]}'.trim();
    }
    return 'One Hundred';
  }

  static List<TableEntry> generateTable(int table) {
    final entries = <TableEntry>[];
    const hindiNumbers = [
      'एक', 'दो', 'तीन', 'चार', 'पाँच', 'छह', 'सात', 'आठ', 'नौ', 'दस',
      'ग्यारह', 'बारह', 'तेरह', 'चौदह', 'पंद्रह', 'सोलह', 'सत्रह',
      'अठारह', 'उन्नीस', 'बीस',
    ];
    for (var i = 1; i <= 10; i++) {
      final result = table * i;
      final enText = '$table ${_tableWord(i)} are $result';
      final hiText = '$table ${hindiNumbers[i - 1]} $result';
      entries.add(TableEntry(text: enText, hindiText: hiText));
    }
    return entries;
  }

  static String _tableWord(int n) {
    switch (n) {
      case 1: return "One's";
      case 2: return "Two's";
      case 3: return "Three's";
      case 4: return "Four's";
      case 5: return "Five's";
      case 6: return "Six's";
      case 7: return "Seven's";
      case 8: return "Eight's";
      case 9: return "Nine's";
      case 10: return "Ten's";
      default: return 'x';
    }
  }

  static final List<int> tables = List.generate(29, (i) => i + 2);
}