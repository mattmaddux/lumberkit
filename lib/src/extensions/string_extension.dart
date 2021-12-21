import 'package:http/http.dart' as http;

extension CapitalizedStringExtension on String {
  String? extension() {
    int dotIndex = this.lastIndexOf('.');
    if (dotIndex == -1) {
      return null;
    }
    return this.substring(dotIndex + 1);
  }

  String? basename() {
    int dotIndex = this.lastIndexOf('.');
    if (dotIndex == -1) {
      return this;
    }
    return this.substring(0, dotIndex);
  }

  Future<bool> urlExists() async {
    final response = await http.head(Uri(path: this));
    return (response.statusCode == 200);
  }

  String toTitleCase() {
    if (this.length <= 1) {
      return this.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = this.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  String before(String substring) {
    if (this.contains(substring)) {
      return this.substring(0, this.indexOf(substring));
    }
    return this;
  }
}
