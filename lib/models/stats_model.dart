class StatModel {
  int? baseStat;
  int? effort;
  String? name;

  StatModel({this.baseStat, this.effort, this.name});
  factory StatModel.fromMap(Map<String, dynamic> map) {
    return StatModel(
        baseStat: map['base_stat'],
        effort: map['effort'],
        name: map['stat']['name']);
  }
}
