import 'package:farmers_app/providers/http_providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ApplyButton extends StatefulWidget {
  const ApplyButton({
    Key? key,
    required this.machineId,
  }) : super(key: key);

  final Object? machineId;

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

var isLoading = false;

class _ApplyButtonState extends State<ApplyButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final applied =
              await Provider.of<HttpProviders>(context, listen: false)
                  .applyForMachine(widget.machineId as String);
          setState(() {
            isLoading = false;
          });
          if (applied) {
            Fluttertoast.showToast(msg: 'applied');
          } else {
            Fluttertoast.showToast(msg: 'something went wrong try again');
          }
        },
        icon: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Icon(
                Icons.unarchive,
                size: 40,
              ),
        label: const Text(
          'Apply',
          style: TextStyle(fontSize: 25),
        ));
  }
}
