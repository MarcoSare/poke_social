import 'package:flutter/material.dart';
import 'package:poke_social/models/event_model.dart';

class DatailsEventScreen extends StatefulWidget {
  List<EventModel> listEvents;
  DatailsEventScreen({super.key, required this.listEvents});

  @override
  State<DatailsEventScreen> createState() => _DatailsEventScreenState();
}

class _DatailsEventScreenState extends State<DatailsEventScreen> {
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/months/september.jpeg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
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
            decoration: const BoxDecoration(
                color: Colors.green,
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
          title: Text(event.id == 1 ? "YES" : "N0",
              style: const TextStyle(fontSize: 16)),
        )
      ]),
    );
  }
}
