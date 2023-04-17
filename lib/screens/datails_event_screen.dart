import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poke_social/database/database_helper.dart';
import 'package:poke_social/models/event_model.dart';

class DatailsEventScreen extends StatefulWidget {
  List<EventModel> listEvents;
  int mes;
  DatailsEventScreen({super.key, required this.listEvents, required this.mes});

  @override
  State<DatailsEventScreen> createState() => _DatailsEventScreenState();
}

class _DatailsEventScreenState extends State<DatailsEventScreen> {
  DatabaseHelper database = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/months/${getMonth(widget.mes)}.jpeg"),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          const Text(
            "Eventos de lunes 20 de marzo de 2023",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _cardEvent(widget.listEvents[index]);
            },
            itemCount: widget.listEvents.length,
          )
        ]),
      ),
    );
  }

  Widget _cardEvent(EventModel event) {
    DateTime date = DateFormat('yyyy-MM-dd HH:mm')
        .parse("${event.dateEvent!} ${event.endTimeEvent}");
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      )),
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        ListTile(
          leading: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: getColorEvent(date, event.completed == 0 ? false : true),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          title: Text(
            event.nameEvent!,
            style: TextStyle(fontSize: 16),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              size: 18,
            ),
          ),
        ),
        ListTile(
          leading: const Text("Description"),
          title: Text(event.descEvent!, style: const TextStyle(fontSize: 16)),
        ),
        ListTile(
          leading: const Text("Start Time"),
          title:
              Text(event.startTimeEvent!, style: const TextStyle(fontSize: 16)),
        ),
        ListTile(
          leading: const Text("end Time"),
          title:
              Text(event.endTimeEvent!, style: const TextStyle(fontSize: 16)),
        ),
        ListTile(
          leading: const Text("Completed"),
          title: Switch(
            value: event.completed == 1 ? true : false,
            onChanged: (bool value) {
              database.UPDATE('tblEvent',
                  {"id": event.id, 'completed': value ? 1 : 0}).then((value) {
                var msg = value > 0 ? 'Evento actualizado' : 'Ocurrió un error';
                var snackBar = SnackBar(content: Text(msg));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              setState(() {
                event.completed = value ? 1 : 0;
              });
            },
          ),
        )
      ]),
    );
  }

  Color getColorEvent(DateTime dateEvent, bool isCompleted) {
    DateTime now =
        DateFormat('yyyy-MM-dd HH:mm').parse(DateTime.now().toString());

    if (isCompleted) {
      return Colors.green;
    } else if (dateEvent.year < now.year) {
      return Colors.red;
    } else if (dateEvent.month < now.month) {
      return Colors.red;
    } else if (dateEvent.month == now.month) {
      if (dateEvent.day < now.day) {
        return Colors.red;
      } else if (dateEvent.day == now.day) {
        if (dateEvent.hour < now.hour) {
          return Colors.red;
        } else if (dateEvent.hour == now.hour) {
          if (dateEvent.minute <= now.minute) {
            return Colors.red;
          } else {
            return Colors.amber;
          }
        } else {
          return Colors.amber;
        }
      } else if ((dateEvent.day - now.day) <= 2) {
        return Colors.amber;
      }
    }
    return Colors.green;
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
}
