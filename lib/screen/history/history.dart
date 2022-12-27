import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/datEfind.dart';
import 'package:hamco/controller/controller.dart';
import 'package:hamco/screen/bottomSheet/transaction_item_info_sheet.dart';
import 'package:hamco/screen/history/alertCommon.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  String form_type;
  HistoryPage({required this.form_type});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime now = DateTime.now();
  // TransaInfoBottomsheet infoshowsheet = TransaInfoBottomsheet();
  AlertCommon popup = AlertCommon();
  DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  TransactionItemInfoSheet itemInfo = TransactionItemInfoSheet();
  ValueNotifier<bool> visible = ValueNotifier(false);
  String? selectedtransaction;
  String? todaydate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(builder: (context, value, child) {
        return Column(
          children: [
        Container(
          height: size.height * 0.08,
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    // String df;
                    // String tf;
                    dateFind.selectDateFind(context, "from date");
                    // if (value.fromDate == null) {
                    //   df = todaydate.toString();
                    // } else {
                    //   df = value.fromDate.toString();
                    // }
                    // if (value.todate == null) {
                    //   tf = todaydate.toString();
                    // } else {
                    //   tf = value.todate.toString();
                    // }
                    // Provider.of<Controller>(context, listen: false)
                    //     .historyData(context, splitted[0], "",
                    //         df, tf);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: P_Settings.loginPagetheme,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  value.fromDate == null
                      ? todaydate.toString()
                      : value.fromDate.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    dateFind.selectDateFind(context, "to date");
                  },
                  icon: Icon(Icons.calendar_month)),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  value.todate == null
                      ? todaydate.toString()
                      : value.todate.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                height: size.height * 0.05,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: P_Settings.loginPagetheme,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(2), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      String df;
                      String tf;

                      if (value.fromDate == null) {
                        df = todaydate.toString();
                      } else {
                        df = value.fromDate.toString();
                      }
                      if (value.todate == null) {
                        tf = todaydate.toString();
                      } else {
                        tf = value.todate.toString();
                      }

                      Provider.of<Controller>(context, listen: false)
                          .historyData(
                              context, "", df, tf, widget.form_type);
                    },
                    child: Text(
                      "Apply",
                      style: GoogleFonts.aBeeZee(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.buttonColor,
                      ),
                    )),
              ))
            ],
          ),
          // dropDownCustom(size,""),
        ),
        Divider(),
        value.isLoading
            ? SpinKitFadingCircle(
                color: P_Settings.loginPagetheme,
              )
            : value.historyList.length == 0
                ? Center(
                    child: Container(
                        height: size.height * 0.2,
                        child: Lottie.asset(
                          'asset/historyjson.json',
                          // height: size.height*0.3,
                          // width: size.height*0.3,
                        )),
                  )
                : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.historyList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          trailing: Wrap(
                            spacing: 10,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .getRequestinfoList(
                                            context,
                                            value.historyList[index]
                                                ['req_id'],
                                            "");
                                    itemInfo.showInfoSheet(context);
                                  },
                                  icon: Icon(Icons.info)),
                              // IconButton(
                              //     icon: Icon(
                              //       Icons.edit,
                              //       color: P_Settings.editclr,
                              //     ),
                              //     onPressed: () {
                              //       // Provider.of<Controller>(context,
                              //       //         listen: false)
                              //       //     .saveCartDetails(
                              //       //         context,
                              //       //         widget.transId,
                              //       //         value.historyList[index]
                              //       //             ['to_branch_id']!,
                              //       //        value.historyList[index]
                              //       //                 ['trans_remark'],
                              //       //         "1");
                              //       Provider.of<Controller>(context,
                              //               listen: false)
                              //           .getBranchList(
                              //               context,
                              //               "history",
                              //               value.historyList[index]
                              //                   ['to_branch_id']!);
                              //       Navigator.pushReplacement<void,
                              //               void>(
                              //           context,
                              //           MaterialPageRoute<void>(
                              //             builder:
                              //                 (BuildContext context) =>
                              //                     TransactionPage(
                              //               page: "history",
                              //               remrk:
                              //                   value.historyList[index]
                              //                       ['trans_remark'],
                              //               branch:
                              //                   value.historyList[index]
                              //                       ['to_branch_id'],
                              //               translist: splitted,
                              //             ),
                              //           ));
                              //     }),
                              // IconButton(
                              //     icon: Icon(
                              //       Icons.delete,
                              //       color: P_Settings.delete,
                              //     ),
                              //     onPressed: () {
                              //       popup.buildPopupDialog(
                              //           context,
                              //           size,
                
                              //           index,
                              //           todaydate!,widget.form_type);
                              // showDialog(
                              //   context: context,
                              //   builder: (ctx) => AlertDialog(
                              //     content: Text(
                              //         "Do you want to delete???"),
                              //     actions: <Widget>[
                
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.end,
                              //         children: [
                              //           ElevatedButton(
                              //             style: ElevatedButton
                              //                 .styleFrom(
                              //                     primary: P_Settings
                              //                         .loginPagetheme),
                              //             onPressed: () async {
                              //               print(
                              //                   "heloooooooooooooooo");
                              //               Provider.of<Controller>(
                              //                       context,
                              //                       listen: false)
                              //                   .saveCartDetails(
                              //                       ctx,
                              //                       splitted[0],
                              //                       value.historyList[
                              //                               index]
                              //                           [
                              //                           'to_branch_id'],
                              //                       value.historyList[
                              //                               index]
                              //                           [
                              //                           'trans_remark'],
                              //                       "2",
                              //                       value.historyList[
                              //                               index]
                              //                           ['os_id'],
                              //                       "delete");
                              //               String df;
                              //               String tf;
                
                              //               if (value.fromDate ==
                              //                   null) {
                              //                 df = todaydate
                              //                     .toString();
                              //               } else {
                              //                 df = value.fromDate
                              //                     .toString();
                              //               }
                              //               if (value.todate ==
                              //                   null) {
                              //                 tf = todaydate
                              //                     .toString();
                              //               } else {
                              //                 tf = value.todate
                              //                     .toString();
                              //               }
                
                              //               //////////////////////////////////////////////////
                
                              //               await Provider.of<
                              //                           Controller>(
                              //                       context,
                              //                       listen: false)
                              //                   .historyData(
                              //                       context,
                              //                       splitted[0],
                              //                       "",
                              //                       df,
                              //                       tf);
                
                              //               //  Navigator.of(ctx)
                              //               //     .pop();
                              //             },
                              //             child: Text("Ok"),
                              //           ),
                              //           SizedBox(
                              //             width:
                              //                 size.width * 0.01,
                              //           ),
                              //           ElevatedButton(
                              //             style: ElevatedButton
                              //                 .styleFrom(
                              //                     primary: P_Settings
                              //                         .loginPagetheme),
                              //             onPressed: () {
                              //               Navigator.of(ctx)
                              //                   .pop();
                              //             },
                              //             child: Text("Cancel"),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // );
                              // }),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Text(
                                      "Series : ",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                        color: P_Settings.historyPageText,
                                      ),
                                    ),
                                    Text(
                                      "${value.historyList[index]['series']} ",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: P_Settings.historyPageText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   width: size.width * 0.03,
                              // ),
                              Row(
                                children: [
                                  // Text(
                                  //   "Date : ",
                                  //   style: GoogleFonts.aBeeZee(
                                  //     textStyle: Theme.of(context)
                                  //         .textTheme
                                  //         .bodyText2,
                                  //     fontSize: 16,
                                  //     // fontStyle: FontStyle.italic,
                                  //     // fontWeight: FontWeight.bold,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  Text(
                                    "Date : ${value.historyList[index]['entry_date']}",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2,
                                      fontSize: 16,
                                      // fontStyle: FontStyle.italic,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Item Count : ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2,
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.historyPageText,
                                  ),
                                ),
                                Text(
                                  "${value.historyList[index]['item_count']}",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.historyPageText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
          ],
        );
      }),
    );
  }
}
