import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poll/Resources/socketMethods.dart';
import 'package:poll/Screens/VoteScreen.dart';
import 'package:poll/Utils/Color.dart';
import 'package:poll/Utils/Text.dart';
import 'package:poll/Utils/widgets.dart';
import 'package:poll/provider/pollsProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController questioncontroller = new TextEditingController();
  TextEditingController pollsquestioncontroller = new TextEditingController();
  List pollsQuestion = [];

  @override
  void initState() {
    SocketMethods().callDatainitStateListeners(context);
    print("initstate");
    super.initState();
  }

  @override
  void dispose() {
    questioncontroller.dispose();
    pollsquestioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pollsQuestion = [];
    final pollsData = Provider.of<PollsProvider>(context);
    final size = MediaQuery.of(context).size;
    SocketMethods().createRoomSuccessListner(context);
    SocketMethods().updateListListner(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    color: Colors.black,
                    duration: const Duration(milliseconds: 500),
                    height: size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextInputField(
                            questioncontroller: questioncontroller,
                            hintText: "Enter your poll name",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: size.width / 1.6,
                                child: CustomTextInputField(
                                    questioncontroller: pollsquestioncontroller,
                                    hintText: "Enter your poll Question"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    pollsQuestion.add({
                                      "pollsQuestion":
                                          pollsquestioncontroller.text,
                                      "pollPercentage": 0
                                    });
                                    showSnackbar(context,
                                        "QuestionAdded ,You can add more question");
                                    pollsquestioncontroller.clear();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 25,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 40,
                                          color: Colors.white,
                                          spreadRadius: 0)
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                SocketMethods().createRoom(
                                    questioncontroller.text, pollsQuestion);
                                questioncontroller.clear();
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text("SAVE", style: buttontextcolor),
                              style: elevatedButtonStyle)
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: fabColor,
      ),
      appBar: AppBar(
        title: Text(
          "Vote Your Favourite",
          style: appBarStyle,
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      backgroundColor: scaffoldColor,
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: pollsData.pollsName.length <= 0
            ? const Center(
                child: Text(
                  "Data is Loading",
                  style: TextStyle(
                      color: Colors.white,
                      shadows: [BoxShadow(blurRadius: 40)],
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: pollsData.pollsName.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      elevation: 3,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: size.width / 2.2),
                                  child: Text(
                                    pollsData.pollsName[index]["pollname"],
                                    style: cardTextStyle,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.25),
                                Expanded(
                                    child: ElevatedButton(
                                        style: elevatedButtonStyle,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VoteScreen(
                                                  uid: pollsData
                                                      .pollsName[index]["uid"],
                                                  pollsQuestion:
                                                      pollsData.pollsName[index]
                                                          ["pollsQuestion"],
                                                  indexofHomepage: index,
                                                ),
                                              ));
                                        },
                                        child: const Text(
                                          "vote",
                                          style: buttontextcolor,
                                        )))
                              ]),
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
