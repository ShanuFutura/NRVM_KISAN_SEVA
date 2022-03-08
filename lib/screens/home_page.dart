import 'package:farmers_app/models/dummies.dart';
import 'package:farmers_app/providers/http_providers.dart';
import 'package:farmers_app/screens/crop_view.dart';
import 'package:farmers_app/screens/faq_list.dart';
// import 'package:farmers_app/screens/fertilizers_list_screen.dart';
import 'package:farmers_app/screens/machinary_list_screen.dart';
import 'package:farmers_app/screens/machines_view.dart';
import 'package:farmers_app/screens/pesticides_and_fertilizers_list.dart';
import 'package:farmers_app/widgets/farmers_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'homepage';

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: FarmersDrawer(),
      appBar: AppBar(
        title: Text('Farmers App'),
      ),
      body: FutureBuilder(
        future: Provider.of<HttpProviders>(context).getCrops(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Crops',
                    style: TextStyle(
                        fontSize: 25, color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  height: deviceHeight * .65,
                  child: ListView.builder(
                      itemCount: (snap.data as List).length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                Dummies.rootUrlforImages +
                                    'Images/' +
                                    (snap.data as dynamic)[index]['image']),
                          ),
                          title: Text((snap.data as dynamic)[index]['crop']),
                          // subtitle: Text('test'),
                          trailing: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  CropView.routeName,
                                  arguments: (snap.data as dynamic)[index]
                                      ['crop_id']);
                            },
                            child: Text('view'),
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(FAQList.routeName);
                      },
                      child: CircleAvatar(
                        radius: deviceHeight * .07,
                        child: Icon(
                          Icons.quiz,
                          size: deviceHeight * .08,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(MachinaryListScreen.routeName);
                      },
                      child: CircleAvatar(
                        radius: deviceHeight * .07,
                        child: Icon(
                          Icons.precision_manufacturing,
                          size: deviceHeight * .08,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PesticidesAndFertilizersList.routeName);
                      },
                      child: CircleAvatar(
                        radius: deviceHeight * .07,
                        child: Icon(
                          Icons.sanitizer,
                          size: deviceHeight * .08,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Couldnt fetch data'),
            );
          }
        },
      ),
    );
  }
}
