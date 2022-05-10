import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MLCam extends StatefulWidget {
  const MLCam({Key? key}) : super(key: key);

  @override
  State<MLCam> createState() => _MLCamState();
}

class _MLCamState extends State<MLCam> {
  File? pickedImage;
  String? errorText;

  pickImage() {
    ImageSource? src;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Row(
            children: [
              TextButton(
                  onPressed: () {
                    src = ImageSource.camera;
                    Navigator.of(context).pop();
                  },
                  child: Text('Cam')),
              TextButton(
                  onPressed: () {
                    src = ImageSource.gallery;
                    Navigator.of(context).pop();
                  },
                  child: Text('Gallery'))
            ],
          ));
        }).then((value) async {
      ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: src!,
        maxHeight: 224,
        maxWidth: 224,
      );
      setState(() => pickedImage = File(pickedFile!.path));
      runAnalyze();
    });
  }

  runAnalyze() async {
    if (pickedImage != null) {
      try {
        final temp = (await Tflite.runModelOnImage(
          imageMean: 224,
          imageStd: 224,
          path: pickedImage!.path,
          numResults: 1,
          threshold: .1,
        ));
        print('response: $temp');
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(temp![0]['confidence'] > .30
                    ? 'There is a ${((temp[0]['confidence']) * 100 as double).toStringAsFixed(2)}% chance for having ${temp[0]['label']}'
                    : 'Seems like healthy leaf'),
              );
            });
        // Fluttertoast.showToast(
        //     msg:
        //         'There is a ${((temp![0]['confidence']) * 100 as double).toStringAsFixed(2)}% chance for having ${temp[0]['label']}',
        //     toastLength: Toast.LENGTH_LONG);
        setState(() {
          errorText =
              'There is a ${((temp![0]['confidence']) * 100 as double).toStringAsFixed(2)}% chance for having ${temp[0]['label']}';
        });
      } on PlatformException catch (err) {
        print('error: $err');
        errorText = err.toString();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.camera_alt_outlined),
      onPressed: pickImage,
    );
  }
}
