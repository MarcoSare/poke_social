import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poke_social/database/database_helper.dart';
import 'package:poke_social/models/event_model.dart';
import 'package:poke_social/screens/datails_event_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  DatabaseHelper database = DatabaseHelper();
  List<EventModel>? events;
  int modeView = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            height: 100,
            width: double.infinity,
            //decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                    const Text(
                      "Add new event",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            modeView = modeView == 0 ? 1 : 0;
                          });
                        },
                        icon: Icon(
                          modeView == 0 ? Icons.list : Icons.calendar_month,
                          size: 32,
                        ))
                  ],
                ),
              ],
            ),
          )),
      body: FutureBuilder(
          future: initData(),
          // ignore: avoid_types_as_parameter_names
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: SfCalendar(
                  backgroundColor: Colors.transparent,
                  cellBorderColor: Colors.transparent,
                  todayHighlightColor: Theme.of(context).primaryColorDark,
                  headerHeight: 100,
                  view: modeView == 0
                      ? CalendarView.month
                      : CalendarView.schedule,
                  dataSource: MeetingDataSource(_getDataSource()),
                  minDate: DateTime(2023, 01, 01, 10, 0, 0),
                  maxDate: DateTime(2023, 12, 31, 10, 0, 0),
                  scheduleViewMonthHeaderBuilder: (BuildContext buildContext,
                      ScheduleViewMonthHeaderDetails details) {
                    final String monthName =
                        getMonth(int.parse(details.date.month.toString()));
                    return Stack(
                      children: [
                        Container(
                          width: details.bounds.width,
                          height: details.bounds.height,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/months/$monthName.jpeg"),
                                  fit: BoxFit.cover)),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.center,
                                colors: [Colors.black54, Colors.black26],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 55,
                          right: 0,
                          top: 20,
                          bottom: 0,
                          child: Text(
                            '$monthName ${details.date.year}',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    );
                  },
                  monthViewSettings: MonthViewSettings(
                      //showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                      monthCellStyle: MonthCellStyle(
                        textStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Theme.of(context).primaryColorLight),
                        leadingDatesTextStyle:
                            TextStyle(color: Theme.of(context).highlightColor),
                        trailingDatesTextStyle:
                            TextStyle(color: Theme.of(context).highlightColor),
                      )),
                  headerStyle: CalendarHeaderStyle(
                      textStyle: TextStyle(
                          color: Theme.of(context).primaryColorLight)),
                  viewHeaderStyle: const ViewHeaderStyle(
                      dayTextStyle: TextStyle(color: Colors.red),
                      dateTextStyle: TextStyle(color: Colors.red)),
                  onTap: calendarTapped,
                ),
              );
            } else {
              return const Center(
                  child: Center(
                      child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              )));
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addEvent');
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
    );
  }

  Future<void> initData() async {
    events = await database.GETALLEVENTS();
    //database.DELETE('tblEvent', 1);
    print(events!.length);
    events!
        .forEach((item) => print(item.dateEvent! + " " + item.startTimeEvent!));
  }

  String getMonth(int index) {
    List<String> months = [
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'octuber',
      'november',
      'december'
    ];
    return months[index - 1];
  }

  Future<void> calendarTapped(CalendarTapDetails details) async {
    print("date hola");
    print(details.date!.toString());
    String aux = details.date!.toString().split(" ")[0];
    List<EventModel> eventFromDate =
        events!.where((event) => event.dateEvent == aux).toList();
    for (var item in eventFromDate) {
      print(item.nameEvent);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DatailsEventScreen(listEvents: eventFromDate)));

    //var appointmentDetails = details.appointments![0];
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    for (EventModel event in events!) {
      List<int> dateEvent = _getDataDate(event.dateEvent!);
      List<int> startTimeEvent = _getTimeDate(event.startTimeEvent!);
      List<int> endTimeEvent = _getTimeDate(event.endTimeEvent!);

      final DateTime startTime = DateTime(dateEvent[0], dateEvent[1],
          dateEvent[2], startTimeEvent[0], startTimeEvent[1]);
      final DateTime endTime = DateTime(dateEvent[0], dateEvent[1],
          dateEvent[2], endTimeEvent[0], endTimeEvent[1]);

      DateTime date = DateFormat('yyyy-MM-dd HH:mm')
          .parse("${event.dateEvent!} ${endTimeEvent[0]}:${endTimeEvent[1]}");
      meetings.add(Meeting(event.nameEvent!, startTime, endTime,
          getColorEvent(date, event.completed == 1 ? true : false), false));
    }

    return meetings;
  }

  // ignore: unused_element
  List<int> _getTimeDate(String date) {
    List<int> data = List.empty(growable: true);
    List<String> aux = DateFormat('HH:mm')
        .format(DateFormat('h:mm a').parse(date))
        .toString()
        .split(":");
    for (var item in aux) {
      data.add(int.parse(item));
    }
    return data;
  }

  // ignore: unused_element
  List<int> _getDataDate(String date) {
    // ignore: prefer_typing_uninitialized_variables
    List<int> data = List.empty(growable: true);
    List<String> aux = date.split("-");
    for (var item in aux) {
      data.add(int.parse(item));
    }
    return data;
  }

  void seeEvents() async {
    List<EventModel> eventos = await database.GETALLEVENTS();
    eventos.forEach((item) => print(item.nameEvent));
  }

  Color getColorEvent(DateTime dateEvent, bool isCompleted) {
    DateTime now =
        DateFormat('yyyy-MM-dd HH:mm').parse(DateTime.now().toString());
    if (isCompleted) return Colors.green;
    Duration diff = dateEvent.difference(now);
    if (diff.inDays == 0 && diff.inMinutes <= 0) return Colors.red;
    if (diff.inDays <= 2) return Colors.yellow;
    return Colors.green;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
