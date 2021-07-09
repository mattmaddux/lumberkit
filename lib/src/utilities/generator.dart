import 'dart:math';

class CharacterSetValues {
  static const CharSetAlphaUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static const CharSetAlphaLower = "abcdefghijklmnopqrstuvwxyz";
  static const CharSetNum = "0123456789";
  static const CharSetSpecial = "!@\$%^&*()-=_+{}[]?<>";

  static String fromSetList(Set<CharacterSet> charSets) {
    if (charSets.contains(CharacterSet.all)) {
      return CharSetAlphaUpper +
          CharSetAlphaLower +
          CharSetNum +
          CharSetSpecial;
    }
    String result = "";
    charSets.forEach(
      (charSet) {
        switch (charSet) {
          case CharacterSet.alphaUpper:
            result += CharSetAlphaUpper;
            break;
          case CharacterSet.alphaLower:
            result += CharSetAlphaLower;
            break;
          case CharacterSet.numeric:
            result += CharSetNum;
            break;
          case CharacterSet.special:
            result += CharSetSpecial;
            break;
          default:
            break;
        }
      },
    );
    return result;
  }
}

enum CharacterSet { alphaUpper, alphaLower, numeric, special, all }

class Generator {
  static String password({
    int length = 16,
    Set<CharacterSet> characterSets = const {CharacterSet.all},
  }) {
    String chars = CharacterSetValues.fromSetList(characterSets);
    String result = "";
    var rand = new Random();
    for (int i = 0; i < length; i++) {
      int charIndex = rand.nextInt(chars.length);
      result += chars[charIndex];
    }
    return result;
  }
}
