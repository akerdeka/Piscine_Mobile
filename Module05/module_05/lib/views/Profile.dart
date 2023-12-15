import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/data_model.dart';
import '../utils/database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/feelings.dart';
import './add_popup.dart';
import './view_card.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  void _onRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FittedBox(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: FutureBuilder(
                      future: Database.getDatas(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: LoadingAnimationWidget.fallingDot(
                                color: Colors.pink.shade100, size: 100),
                          );
                        }
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  children: [
                                    const Text("Your last entries", style: TextStyle(fontSize: 30),),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: Colors.blueGrey),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height / 3,
                                      child: SingleChildScrollView(
                                        child: Column(
                                            children: snapshot.data!.sublist(snapshot.data!.length >= 2 ? snapshot.data!.length - 2 : 0 , snapshot.data!.length).map((e) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () => {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => viewPopupDialog(context, e, _onRefresh),
                                                  )
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink.shade100,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    boxShadow: CupertinoContextMenu.kEndBoxShadow,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text("${DateFormat.E().format(e.date)} ${DateFormat.d().format(e.date)}", style: const TextStyle(color: Colors.black, fontSize: 20)),
                                                            Text(DateFormat.LLLL().format(e.date), style: const TextStyle(color: Colors.black, fontSize: 20)),
                                                            Text(e.date.year.toString(), style: const TextStyle(color: Colors.black, fontSize: 20)),
                                                          ],
                                                        ),
                                                        Expanded(child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Center(child: Text(e.title, style: const TextStyle(color: Colors.black, fontSize: 20))),
                                                        )),
                                                        Feelings.getIcon(e.feeling)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )).toList(),
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  children: [
                                    Text("Your feel for your last ${snapshot.data!.length} entries", style: const TextStyle(fontSize: 30),),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: Colors.blueGrey),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Feelings.getIcon("Happy"),
                                                  Text("${(snapshot.data!.where((element) => element.feeling == "Happy").length / (snapshot.data!.isEmpty ? 1 : snapshot.data!.length) * 100).floorToDouble().toInt()}%", style: const TextStyle(fontSize: 20),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Feelings.getIcon("Satisfied"),
                                                  Text("${(snapshot.data!.where((element) => element.feeling == "Satisfied").length / (snapshot.data!.isEmpty ? 1 : snapshot.data!.length) * 100).floorToDouble().toInt()}%", style: const TextStyle(fontSize: 20),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Feelings.getIcon("Neutral"),
                                                  Text("${(snapshot.data!.where((element) => element.feeling == "Neutral").length / (snapshot.data!.isEmpty ? 1 : snapshot.data!.length) * 100).floorToDouble().toInt()}%", style: const TextStyle(fontSize: 20),)
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Feelings.getIcon("Sad"),
                                                  Text("${(snapshot.data!.where((element) => element.feeling == "Sad").length / (snapshot.data!.isEmpty ? 1 : snapshot.data!.length) * 100).floorToDouble().toInt()}%", style: const TextStyle(fontSize: 20),)
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Feelings.getIcon("Very sad"),
                                                  Text("${(snapshot.data!.where((element) => element.feeling == "Very sad").length / (snapshot.data!.isEmpty ? 1 : snapshot.data!.length) * 100).floorToDouble().toInt()}%", style: const TextStyle(fontSize: 20),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  FittedBox(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AddPopUp(),
                        );
                        _onRefresh();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 30),
                          Text("Add new diary", style: TextStyle(fontSize: 20),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}