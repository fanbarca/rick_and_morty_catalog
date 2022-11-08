enum Gender { MALE, FEMALE, GENDERLESS, UNKNOWN }
enum Species { HUMAN, ALIEN, HUMANOID, UNKNOWN }
enum Status { ALIVE, UNKNOWN, DEAD }
final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE, "Genderless": Gender.GENDERLESS, "unknown": Gender.UNKNOWN});
final speciesValues = EnumValues({"Alien": Species.ALIEN, "Human": Species.HUMAN, "Humanoid": Species.HUMANOID});
final statusValues = EnumValues({"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}
