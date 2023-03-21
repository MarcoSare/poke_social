class EventModel {
  int? id;
  String? nameEvent;
  String? descEvent;
  String? dateEvent;
  String? startTimeEvent;
  String? endTimeEvent;
  int? completed;

  EventModel(
      {this.id,
      this.nameEvent,
      this.descEvent,
      this.dateEvent,
      this.startTimeEvent,
      this.endTimeEvent,
      this.completed});
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        id: map['id'],
        nameEvent: map['nameEvent'],
        descEvent: map['descEvent'],
        dateEvent: map['dateEvent'],
        startTimeEvent: map['startTimeEvent'],
        endTimeEvent: map['endTimeEvent'],
        completed: map['completed']);
  }
}
