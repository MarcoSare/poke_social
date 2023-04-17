import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poke_social/database/database_helper.dart';
import 'package:poke_social/models/event_model.dart';
import 'package:poke_social/widgets/alerts_widget.dart';
import 'package:poke_social/widgets/text_form_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DatabaseHelper database = DatabaseHelper();
  textFormField nameEvent = textFormField(
      "Name event", "Enter Name Event", "Enter Name Event", Icons.event, 1, 50);
  textFormField descEvent = textFormField.area(
      "Description event",
      "Enter description Event",
      "Enter description Event",
      Icons.event,
      1,
      200,
      5);
  AlertsWidget alertsWidget = AlertsWidget();
  final dateFormat = DateFormat("EEE, MMM d, yyyy");
  final timeFormat = DateFormat.yMd().add_jm();
  late String startTime;
  late String endTime;
  late String dateEvent;
  @override
  void initState() {
    super.initState();
    dateEvent = dateFormat.format(DateTime.now()).toString();
    startTime = DateFormat("h:mm a").format(DateTime.now()).toString();
    endTime = startTime;
  }

  @override
  Widget build(BuildContext context) {
    final btnSave = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      text: "Save",
      textColor: Colors.black,
      onPressed: () {
        insertEvent();
      },
      mode: SocialLoginButtonMode.single,
      borderRadius: 15,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      height: 40,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            height: 200,
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
                    btnSave
                  ],
                ),
              ],
            ),
          )),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              nameEvent,
              descEvent,
              const ListTile(
                title: Text(
                  'Date and time',
                ),
                leading: Icon(
                  Icons.date_range,
                ),
              ),
              ListTile(
                title: TextButton(
                    onPressed: () async {
                      await datePicker();
                    },
                    child: Text(
                      dateEvent,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                leading: const Text(
                  "Event date",
                ),
              ),
              ListTile(
                title: TextButton(
                    onPressed: () async {
                      await displayTimeDialog();
                    },
                    child: Text(startTime)),
                leading: const Text(
                  "Start time",
                ),
              ),
              ListTile(
                title: TextButton(
                    onPressed: () async {
                      endTime == null
                          ? await alertsWidget.show(
                              context, "Error", "Select a start time")
                          : await displayTimeDialog2();
                    },
                    child: Text(endTime)),
                leading: const Text(
                  "End time",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> displayTimeDialog() async {
    //DateFormat("h:mm a").format
    String timeConv = DateFormat('HH:mm')
        .format(DateFormat('h:mm a').parse(startTime))
        .toString();
    TimeOfDay timeAux = TimeOfDay(
        hour: int.parse(timeConv.split(":")[0]),
        minute: int.parse(timeConv.split(":")[1]));
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: timeAux);
    if (time != null) {
      setState(() {
        startTime = time.format(context).toString();
        endTime = startTime;
      });
    }
  }

  Future<void> displayTimeDialog2() async {
    //DateFormat("h:mm a").format
    String timeConv = DateFormat('HH:mm')
        .format(DateFormat('h:mm a').parse(endTime))
        .toString();
    TimeOfDay timeAux = TimeOfDay(
        hour: int.parse(timeConv.split(":")[0]),
        minute: int.parse(timeConv.split(":")[1]));
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: timeAux);
    if (time != null) {
      setState(() {
        String aux = time.format(context).toString();
        if (diffTime(startTime, aux)) {
          endTime = aux;
        } else {
          alertsWidget.show(
              context, "Error", "End time must be greater than start time");
        }
      });
    }
  }

  Future<void> datePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (date != null) {
      setState(() {
        dateEvent = dateFormat.format(date).toString();
      });
    }
  }

  List<int> getHourMin(String time) {
    int hour = int.parse(time.split(":")[0]);
    int min = int.parse(time.split(":")[1].split(" ")[0]);
    int aaa = time.split(" ")[1] == 'AM' ? 0 : 1; // AM => 0 and PM =>1
    return [hour, min, aaa];
  }

  bool diffTime(String start, String end) {
    List<int> dataStart = getHourMin(start);
    List<int> dataEnd = getHourMin(end);
    if (dataStart[0] > dataEnd[0]) return false;
    if (dataStart[0] == dataEnd[0]) {
      if (dataStart[1] > dataEnd[1]) return false;
    }
    return true;
  }

  bool validate() {
    if (nameEvent.formKey.currentState!.validate()) {
      if (descEvent.formKey.currentState!.validate()) return true;
    }
    return false;
  }

  void insertEvent() {
    if (validate()) {
      database.INSERT('tblEvent', {
        'nameEvent': nameEvent.controlador,
        'descEvent': descEvent.controlador,
        'dateEvent': DateFormat('yyyy-MM-dd')
            .format(dateFormat.parse(dateEvent))
            .toString(),
        'startTimeEvent': startTime,
        'endTimeEvent': endTime,
        'completed': 0
      }).then((value) {
        var msg = value > 0 ? 'Registro insertado' : 'Ocurrió un error';

        var snackBar = SnackBar(content: Text(msg));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  void seeEvents() async {
    List<EventModel> eventos = await database.GETALLEVENTS();
    eventos.forEach((item) => print(item.nameEvent));
  }
}
/*
showCustomTimePicker(
                            context: context,
                            onFailValidation: (context) =>
                                print('Unavailable selection'),
                            initialTime: TimeOfDay(hour: 2, minute: 0))
                        .then(
                            (time) => setState(() => print(time?.toString())));
*/