extension StringExtension on String {
  String capFirstLetter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
