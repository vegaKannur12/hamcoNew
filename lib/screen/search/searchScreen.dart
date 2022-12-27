import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/controller/controller.dart';
import 'package:hamco/screen/bottomSheet/infoBottomsheet.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  String type;
  SearchScreen({required this.type});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchcontroll = TextEditingController();
  InfoBottomsheet infoshowsheet = InfoBottomsheet();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<Controller>(context, listen: false).searchList.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: size.width * 0.95,
              height: size.height * 0.09,
              child: TextField(
                autofocus: true,
                controller: searchcontroll,
                onChanged: (value) {
                  if (value != null || value.isNotEmpty) {
                    print("value-----$value");
                    Provider.of<Controller>(context, listen: false)
                        .setIssearch(true);
                    // value = searchcontroll.text;
                    Provider.of<Controller>(context, listen: false)
                        .searchItem(context, value);
                  } else {
                    Provider.of<Controller>(context, listen: false)
                        .setIssearch(false);
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search Item here",
                  prefixIcon: Icon(
                    Icons.search,
                    color: P_Settings.loginPagetheme,
                  ),
                  hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: P_Settings.loginPagetheme),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 94, 95, 94)),
                  ),
                ),
              ),
            ),
          ),
          Consumer<Controller>(builder: (context, value, child) {
            if (value.isSearch == false) {
              // return SpinKitFadingCircle(
              //   color: P_Settings.loginPagetheme,
              // );
              return Container(
                  height: size.height * 0.2,
                  // width: size.width*0.6,
                  // child: Text("No Data Found !!!"),
                  child: Lottie.asset(
                    'asset/search1.json',
                    // height: size.height*0.3,
                    // width: size.height*0.3,
                  ));
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: value.searchList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        // Provider.of<Controller>(context, listen: false)
                        //     .getinfoList(
                        //         context, value.searchList[index]["item_id"]);
                        // infoshowsheet.showInfoSheet(context);
                      },
                      title: Row(
                        children: [Text(value.searchList[index]["item_name"])],
                      ),
                      subtitle: Row(
                        children: [
                          Text("SRate1 :  ${value.searchList[index]["s_rate_1"]}"),
                          // SizedBox(
                          //   width: size.width * 0.03,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0),
                            child: Text("SRate2 :  ${value.searchList[index]["s_rate_2"]}"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
