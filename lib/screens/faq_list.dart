import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQList extends StatefulWidget {
  const FAQList({Key? key}) : super(key: key);

  static const String routeName = 'faqlist';

  @override
  State<FAQList> createState() => _FAQListState();
}

var faquestion = '';
final faqController = TextEditingController();

class _FAQListState extends State<FAQList> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: Dummies.faqList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Dummies.faqList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: faquestion.trim().isEmpty
            ? Colors.grey
            : Theme.of(context).primaryColor,
        onPressed: faquestion.trim().isEmpty
            ? null
            : () {
                setState(() {
                  Provider.of<HttpProviders>(context, listen: false)
                      .sendFAQ(faqController.text);
                  faquestion = '';
                  faqController.clear();
                  FocusScope.of(context).unfocus();
                });
              },
        child: Icon(
            faquestion.trim().isEmpty ? Icons.contact_support : Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: BottomAppBar(
            // clipBehavior: Clip.  ,
            notchMargin: 10,
            color: Colors.green,
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
                  // color: Colors.white,
                  // height: 50,
                  // width: 100,
                ),
              ),
            ),
            //
            // width: double.infinity,
            // height: 60,
          )),
    );
  }
}
