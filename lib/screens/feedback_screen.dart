import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  static const String routeName = 'feedback screen';

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final feedController = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.grey.withOpacity(.5),
              padding:const EdgeInsets.all(5),
              child: TextField(
                controller: feedController,
                maxLines: 15,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final isSent =
              await Provider.of<HttpProviders>(context, listen: false)
                  .feedBackSend(feedController.text);
          setState(() {
            isLoading = false;
          });
          if (isSent) {
            Fluttertoast.showToast(msg: 'feedback sent');
            feedController.clear();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Couldn\'t send feedback'),
                  );
                });
          }

          // feedController.clear();
        },
        child: isLoading ? const CircularProgressIndicator() :const Icon(Icons.send),
      ),
    );
  }
}
