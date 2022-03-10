import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FAQList extends StatefulWidget {
  const FAQList({Key? key}) : super(key: key);

  static const String routeName = 'faqlist';

  @override
  State<FAQList> createState() => _FAQListState();
}

var faquestion = '';
final faqController = TextEditingController();
var isSending = false;

class _FAQListState extends State<FAQList> {
  popUpAnser(BuildContext context, String reply) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('answer: ' + reply),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: FutureBuilder(
          future: Provider.of<HttpProviders>(context).getFAQList(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              return ListView.builder(
                itemCount: (snap.data as List).length,
                itemBuilder: (context, index) {
                  final hasReply =
                      ((snap.data as dynamic)[index]['reply'] == '');
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onTap: hasReply
                            ? () {
                                Fluttertoast.showToast(
                                    msg: 'No reply recieved',
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            : () {
                                popUpAnser(context,
                                    (snap.data as dynamic)[index]['reply']);
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          width: double.infinity,
                          child: Card(
                            color: hasReply
                                ? Theme.of(context).canvasColor
                                : Theme.of(context).primaryColorLight,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text((snap.data as dynamic)[index]['doubt']),
                            ),
                          ),
                        ),
                      ),
                      if (!hasReply)
                        const Positioned(
                          right: 10,
                          top: 5,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                          ),
                        )
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Text('something went wrong'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: faquestion.trim().isEmpty
            ? Colors.grey
            : Theme.of(context).primaryColor,
        onPressed: faquestion.trim().isEmpty
            ? null
            : () async {
                setState(() {
                  isSending = true;
                });
                final succeed =
                    await Provider.of<HttpProviders>(context, listen: false)
                        .sendFAQ(faqController.text);
                setState(() {
                  isSending = false;
                  Fluttertoast.showToast(
                      msg: succeed ? 'sent' : 'couldn\'t send');
                  if (succeed) {
                    // Dummies.faqList.add(faquestion);
                  }
                  faquestion = '';
                  faqController.clear();
                  FocusScope.of(context).unfocus();
                });
              },
        child: isSending
            ? CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/step2_sending.gif'))
            : Icon(
                faquestion.trim().isEmpty ? Icons.contact_support : Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: BottomAppBar(
            notchMargin: 10,
            color: Theme.of(context).primaryColor,
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: TextFormField(
                  controller: faqController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'type your doubts',
                  ),
                  onChanged: (value) {
                    setState(() {
                      faquestion = value;
                    });
                  },
                ),
              ),
            ),
          )),
    );
  }
}
