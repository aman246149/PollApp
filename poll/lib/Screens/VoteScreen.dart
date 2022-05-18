import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poll/Resources/socketMethods.dart';
import 'package:poll/Utils/Color.dart';
import 'package:poll/Utils/Text.dart';
import 'package:poll/provider/pollsProvider.dart';
import 'package:provider/provider.dart';

class VoteScreen extends StatefulWidget {
  final String uid;
  final List pollsQuestion;
  final int indexofHomepage;
  const VoteScreen({
    Key? key,
    required this.uid,
    required this.pollsQuestion,
    required this.indexofHomepage,
  }) : super(key: key);

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String isChecked = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SocketMethods().updateListListner(context);
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    final roomData = Provider.of<PollsProvider>(context);
    print(roomData.pollsName[0]["pollsQuestion"].length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vote Your Choice",
          style: appBarStyle,
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
      ),
      backgroundColor: scaffoldColor,
      body: Card(
        elevation: 5,
        child: ListView.builder(
          itemCount: roomData
              .pollsName[widget.indexofHomepage]["pollsQuestion"].length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                SocketMethods().checkBoxPressedUpdateData(widget.uid,
                    widget.pollsQuestion[index]["pollsQuestion"], index);

                SocketMethods().updateListListner(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        roomData.pollsName[widget.indexofHomepage]
                                ["pollsQuestion"][index]["pollsQuestion"]
                            .toString(),
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(blurRadius: 30, color: Colors.green)
                            ]),
                      ),
                      subtitle: LinearProgressIndicator(
                        backgroundColor: Colors.black12,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.deepPurpleAccent),
                        minHeight: 25,
                        value: roomData.pollsName[widget.indexofHomepage]
                                    ["pollsQuestion"][index]["pollPercentage"]
                                .toDouble() *
                            0.01,
                      ),
                      trailing: Text(
                        "${roomData.pollsName[widget.indexofHomepage]["pollsQuestion"][index]["pollPercentage"]} %"
                            .toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(blurRadius: 30, color: Colors.green)
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
