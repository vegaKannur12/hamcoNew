import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/customSnackbar.dart';
import 'package:hamco/components/globaldata.dart';
import 'package:hamco/controller/controller.dart';

import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

class InfoBottomsheet {
  showInfoSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    String imgGlobal = Globaldata.imageurl;

    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Item Info :",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        // ListTile(
                        //   title: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       // Text("Product Name"),Spacer(),
                        //       Text(
                        //         "Item Info :",
                        //         style: GoogleFonts.aBeeZee(
                        //           textStyle:
                        //               Theme.of(context).textTheme.bodyText2,
                        //           fontSize: 17,
                        //           fontWeight: FontWeight.bold,
                        //           color: P_Settings.loginPagetheme,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        // Container(
                        //   height: size.height * 0.2,
                        //   child: FadeInImage(
                        //     height: 200,
                        //     width: 300,
                        //     fit: BoxFit.fill,
                        //     placeholder: AssetImage("asset/ajax_loader.gif"),
                        //     image: NetworkImage(
                        //       imgGlobal + value.infoList[0]["item_img"],
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 80,
                                child: value.infoList[0]["item_img"] == null ||
                                        value.infoList[0]["item_img"].isEmpty
                                    ? Image.asset(
                                        'asset/noImg.png',
                                        fit: BoxFit.cover,
                                      )
                                    : PhotoView(
                                        imageProvider: NetworkImage(
                                          imgGlobal +
                                              value.infoList[0]["item_img"],
                                          // fit: BoxFit.cover,
                                        ),
                                        // minScale:
                                        //     PhotoViewComputedScale.contained *
                                        //         0.8,
                                        // maxScale:
                                        //     PhotoViewComputedScale.covered * 2,
                                      ),

                                // backgroundImage: NetworkImage(
                                //   imgGlobal + value.infoList[0]["item_img"],
                                // ),
                                // backgroundColor: Colors.transparent,
                                // child: Image.network(
                                //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                //   fit: BoxFit.cover,
                                // ),
                                // child: Image.asset("asset/"),
                              ),
                              //       //  SizedBox(
                              //       //   width: size.width * 0.5,
                              //       // ),

                              //       // Spacer(),
                              //       // Text(
                              //       //       prodName.toString(),
                              //       //       style: GoogleFonts.aBeeZee(
                              //       //         textStyle:
                              //       //             Theme.of(context).textTheme.bodyText2,
                              //       //         fontSize: 17,
                              //       //         // fontWeight: FontWeight.bold,
                              //       //         color: P_Settings.loginPagetheme,
                              //       //       ),
                              //       //     ),
                            ],
                          ),
                        ),

                        ListTile(
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          // leading: CircleAvatar(
                          //   radius: 30,
                          //   backgroundImage: NetworkImage(
                          //       'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                          //   backgroundColor: Colors.transparent,
                          //   // child: Image.network(
                          //   //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                          //   //   fit: BoxFit.cover,
                          //   // ),
                          //   // child: Image.asset("asset/"),
                          // ),
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    value.infoList[0]["item_name"].toString(),
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "MOP",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\u{20B9}${value.infoList[0]["s_rate_1"].toString()}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "MRP",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\u{20B9}${value.infoList[0]["s_rate_2"].toString()}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text("Product Name"),Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Stock Info : ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Branch Name",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Stock",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 20,
                        ),
                        Container(
                          height: value.stockList.length == 1
                              ? size.height * 0.1
                              : value.stockList.length == 2
                                  ? size.height * 0.2
                                  : size.height * 0.3,
                          // value.stockList.length == 2
                          //     ? size.height * 0.1
                          //     : size.height * 0.2,
                          child: ListView.builder(
                            itemCount: value.stockList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value.stockList[index]["BranchName"],
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                            color: value.stockList[index]
                                                        ["st"] ==
                                                    "0"
                                                ? Colors.grey[600]
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        value.stockList[index]["stock"],
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 17,
                                          // fontWeight: FontWeight.bold,
                                          color: value.stockList[index]["st"] ==
                                                  "0"
                                              ? Colors.grey[600]
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
