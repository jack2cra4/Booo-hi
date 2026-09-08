import '../models/lesson.dart';

class EnglishData {
  static const capitalLetters = [
    LetterItem(character: 'A', transliteration: 'ऐ', word: 'Apple', wordMeaning: 'सेब', audioLabel: 'A'),
    LetterItem(character: 'B', transliteration: 'बी', word: 'Ball', wordMeaning: 'गेंद', audioLabel: 'B'),
    LetterItem(character: 'C', transliteration: 'सी', word: 'Cat', wordMeaning: 'बिल्ली', audioLabel: 'C'),
    LetterItem(character: 'D', transliteration: 'डी', word: 'Dog', wordMeaning: 'कुत्ता', audioLabel: 'D'),
    LetterItem(character: 'E', transliteration: 'ई', word: 'Elephant', wordMeaning: 'हाथी', audioLabel: 'E'),
    LetterItem(character: 'F', transliteration: 'एफ', word: 'Fish', wordMeaning: 'मछली', audioLabel: 'F'),
    LetterItem(character: 'G', transliteration: 'जी', word: 'Goat', wordMeaning: 'बकरी', audioLabel: 'G'),
    LetterItem(character: 'H', transliteration: 'एच', word: 'House', wordMeaning: 'घर', audioLabel: 'H'),
    LetterItem(character: 'I', transliteration: 'आई', word: 'Ice', wordMeaning: 'बर्फ', audioLabel: 'I'),
    LetterItem(character: 'J', transliteration: 'जे', word: 'Jug', wordMeaning: 'जग', audioLabel: 'J'),
    LetterItem(character: 'K', transliteration: 'के', word: 'Kite', wordMeaning: 'पतंग', audioLabel: 'K'),
    LetterItem(character: 'L', transliteration: 'एल', word: 'Lion', wordMeaning: 'शेर', audioLabel: 'L'),
    LetterItem(character: 'M', transliteration: 'एम', word: 'Monkey', wordMeaning: 'बंदर', audioLabel: 'M'),
    LetterItem(character: 'N', transliteration: 'एन', word: 'Nest', wordMeaning: 'घोंसला', audioLabel: 'N'),
    LetterItem(character: 'O', transliteration: 'ओ', word: 'Orange', wordMeaning: 'संतरा', audioLabel: 'O'),
    LetterItem(character: 'P', transliteration: 'पी', word: 'Pen', wordMeaning: 'कलम', audioLabel: 'P'),
    LetterItem(character: 'Q', transliteration: 'क्यू', word: 'Queen', wordMeaning: 'रानी', audioLabel: 'Q'),
    LetterItem(character: 'R', transliteration: 'आर', word: 'Rose', wordMeaning: 'गुलाब', audioLabel: 'R'),
    LetterItem(character: 'S', transliteration: 'एस', word: 'Sun', wordMeaning: 'सूरज', audioLabel: 'S'),
    LetterItem(character: 'T', transliteration: 'टी', word: 'Tiger', wordMeaning: 'बाघ', audioLabel: 'T'),
    LetterItem(character: 'U', transliteration: 'यू', word: 'Umbrella', wordMeaning: 'छाता', audioLabel: 'U'),
    LetterItem(character: 'V', transliteration: 'वी', word: 'Van', wordMeaning: 'वैन', audioLabel: 'V'),
    LetterItem(character: 'W', transliteration: 'डबल्यू', word: 'Watch', wordMeaning: 'घड़ी', audioLabel: 'W'),
    LetterItem(character: 'X', transliteration: 'एक्स', word: 'X-ray', wordMeaning: 'एक्स-रे', audioLabel: 'X'),
    LetterItem(character: 'Y', transliteration: 'वाय', word: 'Yak', wordMeaning: 'याक', audioLabel: 'Y'),
    LetterItem(character: 'Z', transliteration: 'ज़ेड', word: 'Zebra', wordMeaning: 'ज़ेबरा', audioLabel: 'Z'),
  ];

  static const smallLetters = [
    LetterItem(character: 'a', transliteration: 'ऐ', word: 'apple', wordMeaning: 'सेब', audioLabel: 'a'),
    LetterItem(character: 'b', transliteration: 'बी', word: 'ball', wordMeaning: 'गेंद', audioLabel: 'b'),
    LetterItem(character: 'c', transliteration: 'सी', word: 'cat', wordMeaning: 'बिल्ली', audioLabel: 'c'),
    LetterItem(character: 'd', transliteration: 'डी', word: 'dog', wordMeaning: 'कुत्ता', audioLabel: 'd'),
    LetterItem(character: 'e', transliteration: 'ई', word: 'elephant', wordMeaning: 'हाथी', audioLabel: 'e'),
    LetterItem(character: 'f', transliteration: 'एफ', word: 'fish', wordMeaning: 'मछली', audioLabel: 'f'),
    LetterItem(character: 'g', transliteration: 'जी', word: 'goat', wordMeaning: 'बकरी', audioLabel: 'g'),
    LetterItem(character: 'h', transliteration: 'एच', word: 'house', wordMeaning: 'घर', audioLabel: 'h'),
    LetterItem(character: 'i', transliteration: 'आई', word: 'ice', wordMeaning: 'बर्फ', audioLabel: 'i'),
    LetterItem(character: 'j', transliteration: 'जे', word: 'jug', wordMeaning: 'जग', audioLabel: 'j'),
    LetterItem(character: 'k', transliteration: 'के', word: 'kite', wordMeaning: 'पतंग', audioLabel: 'k'),
    LetterItem(character: 'l', transliteration: 'एल', word: 'lion', wordMeaning: 'शेर', audioLabel: 'l'),
    LetterItem(character: 'm', transliteration: 'एम', word: 'monkey', wordMeaning: 'बंदर', audioLabel: 'm'),
    LetterItem(character: 'n', transliteration: 'एन', word: 'nest', wordMeaning: 'घोंसला', audioLabel: 'n'),
    LetterItem(character: 'o', transliteration: 'ओ', word: 'orange', wordMeaning: 'संतरा', audioLabel: 'o'),
    LetterItem(character: 'p', transliteration: 'पी', word: 'pen', wordMeaning: 'कलम', audioLabel: 'p'),
    LetterItem(character: 'q', transliteration: 'क्यू', word: 'queen', wordMeaning: 'रानी', audioLabel: 'q'),
    LetterItem(character: 'r', transliteration: 'आर', word: 'rose', wordMeaning: 'गुलाब', audioLabel: 'r'),
    LetterItem(character: 's', transliteration: 'एस', word: 'sun', wordMeaning: 'सूरज', audioLabel: 's'),
    LetterItem(character: 't', transliteration: 'टी', word: 'tiger', wordMeaning: 'बाघ', audioLabel: 't'),
    LetterItem(character: 'u', transliteration: 'यू', word: 'umbrella', wordMeaning: 'छाता', audioLabel: 'u'),
    LetterItem(character: 'v', transliteration: 'वी', word: 'van', wordMeaning: 'वैन', audioLabel: 'v'),
    LetterItem(character: 'w', transliteration: 'डबल्यू', word: 'watch', wordMeaning: 'घड़ी', audioLabel: 'w'),
    LetterItem(character: 'x', transliteration: 'एक्स', word: 'x-ray', wordMeaning: 'एक्स-रे', audioLabel: 'x'),
    LetterItem(character: 'y', transliteration: 'वाय', word: 'yak', wordMeaning: 'याक', audioLabel: 'y'),
    LetterItem(character: 'z', transliteration: 'ज़ेड', word: 'zebra', wordMeaning: 'ज़ेबरा', audioLabel: 'z'),
  ];

  static const twoLetterWords = [
    WordItem(hindi: 'AT', english: 'AT', meaning: 'पर', length: 2),
    WordItem(hindi: 'AN', english: 'AN', meaning: 'एक', length: 2),
    WordItem(hindi: 'IN', english: 'IN', meaning: 'में', length: 2),
    WordItem(hindi: 'ON', english: 'ON', meaning: 'पर', length: 2),
    WordItem(hindi: 'UP', english: 'UP', meaning: 'ऊपर', length: 2),
    WordItem(hindi: 'TO', english: 'TO', meaning: 'को', length: 2),
    WordItem(hindi: 'IS', english: 'IS', meaning: 'है', length: 2),
    WordItem(hindi: 'GO', english: 'GO', meaning: 'जाओ', length: 2),
    WordItem(hindi: 'NO', english: 'NO', meaning: 'नहीं', length: 2),
  ];

  static const threeLetterWords = [
    WordItem(hindi: 'CAT', english: 'CAT', meaning: 'बिल्ली', length: 3),
    WordItem(hindi: 'BAT', english: 'BAT', meaning: 'बल्ला', length: 3),
    WordItem(hindi: 'PEN', english: 'PEN', meaning: 'कलम', length: 3),
    WordItem(hindi: 'PIN', english: 'PIN', meaning: 'पिन', length: 3),
    WordItem(hindi: 'DOG', english: 'DOG', meaning: 'कुत्ता', length: 3),
    WordItem(hindi: 'SUN', english: 'SUN', meaning: 'सूरज', length: 3),
    WordItem(hindi: 'RUN', english: 'RUN', meaning: 'दौड़ना', length: 3),
    WordItem(hindi: 'FAN', english: 'FAN', meaning: 'पंखा', length: 3),
    WordItem(hindi: 'HEN', english: 'HEN', meaning: 'मुर्गी', length: 3),
    WordItem(hindi: 'BED', english: 'BED', meaning: 'बिस्तर', length: 3),
    WordItem(hindi: 'CUP', english: 'CUP', meaning: 'कप', length: 3),
    WordItem(hindi: 'BUG', english: 'BUG', meaning: 'कीड़ा', length: 3),
    WordItem(hindi: 'RED', english: 'RED', meaning: 'लाल', length: 3),
    WordItem(hindi: 'SIT', english: 'SIT', meaning: 'बैठो', length: 3),
    WordItem(hindi: 'HOT', english: 'HOT', meaning: 'गर्म', length: 3),
  ];

  static const fourLetterWords = [
    WordItem(hindi: 'BALL', english: 'BALL', meaning: 'गेंद', length: 4),
    WordItem(hindi: 'BOOK', english: 'BOOK', meaning: 'किताब', length: 4),
    WordItem(hindi: 'FISH', english: 'FISH', meaning: 'मछली', length: 4),
    WordItem(hindi: 'TREE', english: 'TREE', meaning: 'पेड़', length: 4),
    WordItem(hindi: 'MILK', english: 'MILK', meaning: 'दूध', length: 4),
    WordItem(hindi: 'SHIP', english: 'SHIP', meaning: 'जहाज', length: 4),
    WordItem(hindi: 'CHAT', english: 'CHAT', meaning: 'बातचीत', length: 4),
    WordItem(hindi: 'STAR', english: 'STAR', meaning: 'तारा', length: 4),
    WordItem(hindi: 'CLOUD', english: 'CLOUD', meaning: 'बादल', length: 5),
    WordItem(hindi: 'BIRD', english: 'BIRD', meaning: 'पक्षी', length: 4),
    WordItem(hindi: 'FLAG', english: 'FLAG', meaning: 'झंडा', length: 4),
    WordItem(hindi: 'MOON', english: 'MOON', meaning: 'चाँद', length: 4),
  ];

  static const blends = [
    WordItem(hindi: 'BL', english: 'BL', meaning: 'बीएल', length: 2),
    WordItem(hindi: 'CL', english: 'CL', meaning: 'सीएल', length: 2),
    WordItem(hindi: 'ST', english: 'ST', meaning: 'एसटी', length: 2),
    WordItem(hindi: 'SH', english: 'SH', meaning: 'श', length: 2),
    WordItem(hindi: 'CH', english: 'CH', meaning: 'च', length: 2),
    WordItem(hindi: 'TH', english: 'TH', meaning: 'थ', length: 2),
  ];

  static const blendWords = [
    WordItem(hindi: 'BLOCK', english: 'BLOCK', meaning: 'ब्लॉक', length: 5),
    WordItem(hindi: 'CLOUD', english: 'CLOUD', meaning: 'बादल', length: 5),
    WordItem(hindi: 'STAR', english: 'STAR', meaning: 'तारा', length: 4),
    WordItem(hindi: 'SHOP', english: 'SHOP', meaning: 'दुकान', length: 4),
    WordItem(hindi: 'CHIP', english: 'CHIP', meaning: 'चिप', length: 4),
    WordItem(hindi: 'THREE', english: 'THREE', meaning: 'तीन', length: 5),
  ];

  static const complexPhonics = [
    WordItem(hindi: 'CAKE', english: 'CAKE', meaning: 'केक (लंबा A)', length: 4),
    WordItem(hindi: 'BIRD', english: 'BIRD', meaning: 'पक्षी (शांत R)', length: 4),
    WordItem(hindi: 'NIGHT', english: 'NIGHT', meaning: 'रात (शांत GH)', length: 5),
    WordItem(hindi: 'ROAD', english: 'ROAD', meaning: 'सड़क (लंबा O)', length: 4),
    WordItem(hindi: 'SMILE', english: 'SMILE', meaning: 'मुस्कान (शांत E)', length: 5),
    WordItem(hindi: 'ELEPHANT', english: 'ELEPHANT', meaning: 'हाथी', length: 8),
  ];

  static const bilingualSentences = [
    WordItem(hindi: 'मैं स्कूल जाता हूँ।', english: 'I go to school.', meaning: 'My school journey', length: 0),
    WordItem(hindi: 'पानी पीओ।', english: 'Drink water.', meaning: 'Stay hydrated', length: 0),
    WordItem(hindi: 'किताब पढ़ो।', english: 'Read the book.', meaning: 'Book reading', length: 0),
    WordItem(hindi: 'सूरज चमकता है।', english: 'The sun shines.', meaning: 'Sun is bright', length: 0),
    WordItem(hindi: 'मुझे खेलना पसंद है।', english: 'I like to play.', meaning: 'Playing is fun', length: 0),
    WordItem(hindi: 'आपका नाम क्या है?', english: 'What is your name?', meaning: 'Introducing yourself', length: 0),
    WordItem(hindi: 'यह मेरा घर है।', english: 'This is my home.', meaning: 'My home', length: 0),
    WordItem(hindi: 'हम दोस्त हैं।', english: 'We are friends.', meaning: 'Friendship', length: 0),
    WordItem(hindi: 'आज बहुत गर्मी है।', english: 'It is very hot today.', meaning: 'Weather', length: 0),
    WordItem(hindi: 'एक दो तीन।', english: 'One two three.', meaning: 'Counting', length: 0),
  ];

  static const numberWords = [
    'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE', 'TEN',
    'ELEVEN', 'TWELVE', 'THIRTEEN', 'FOURTEEN', 'FIFTEEN', 'SIXTEEN', 'SEVENTEEN',
    'EIGHTEEN', 'NINETEEN', 'TWENTY',
  ];
}