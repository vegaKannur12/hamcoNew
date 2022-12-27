import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/customSnackbar.dart';
import 'package:hamco/controller/controller.dart';
import 'package:hamco/screen/bottomSheet/searchSheet.dart';
import 'package:hamco/screen/dashboard/mainDashboard.dart';
import 'package:hamco/screen/history/history.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StockReturn extends StatefulWidget {
  String form_type;
  String title;
  StockReturn({required this.form_type, required this.title});

  @override
  State<StockReturn> createState() => _StockReturnState();
}

class _StockReturnState extends State<StockReturn> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<bool> visible = ValueNotifier(false);
  CustomSnackbar snackbar = CustomSnackbar();
  String? date;
  String? type;
  bool arrowClicked = false;
  List<String> s = [];
  DateTime now = DateTime.now();
  // String? selected;
  String? todaydate;
  SearchBottomSheet searchSheet = SearchBottomSheet();
  TextEditingController remrk = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: size.height * 0.05,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: P_Settings.loginPagetheme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2), // <-- Radius
              ),
            ),
            onPressed: () async {
              if (Provider.of<Controller>(context, listen: false)
                      .bagList
                      .length >
                  0) {
                return showDialog(
                    context: _scaffoldKey.currentContext!,
                    barrierDismissible: true,
                    builder: (BuildContext ctx) {
                      return new AlertDialog(
                        content: Text("Do you want to Return ???"),
                        actions: <Widget>[
                          Consumer<Controller>(
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: () async {
                                      print("heloooooooooooooooo-----");
                                      if (value.selected == null ||
                                          value.selected!.isEmpty) {
                                        Navigator.of(
                                                _scaffoldKey.currentContext!)
                                            .pop();
                                        snackbar.showSnackbar(context,
                                            "Please Select Project", "");
                                      } else {
                                        Navigator.of(
                                                _scaffoldKey.currentContext!)
                                            .pop();
                                        showDailogue(
                                            context, true, _keyLoader, 1);
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .saveReturnCartDetails(
                                                _scaffoldKey.currentContext!,
                                                remrk.text,
                                                "0",
                                                "0",
                                                "save",
                                                "",
                                                value.selected!);
                                        // Navigator.pop(ctx);

                                      }
                                    },

                                    // Navigator.of(ctx).pop();

                                    child: Text("Ok"),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    });
              }
              // Provider.of<Controller>(context, listen: false).saveCartDetails(
              //     context,
              //     splitted[0],
              //     selectedbranch.toString(),
              //     remrk.text,
              //     "0",
              //     "0",
              //     "save");
            },
            child: Text(
              'Return',
              style: GoogleFonts.aBeeZee(
                textStyle: Theme.of(context).textTheme.bodyText2,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: P_Settings.buttonColor,
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      appBar: AppBar(
          title: Text(
            widget.title.toString(),
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<Controller>(context, listen: false).fromDate =
                      null;
                  Provider.of<Controller>(context, listen: false).todate = null;

                  Provider.of<Controller>(context, listen: false)
                      .historyList
                      .clear();
                  Provider.of<Controller>(context, listen: false).historyData(
                      context, "", todaydate!, todaydate!, widget.form_type);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HistoryPage(form_type: widget.form_type)),
                  );
                },
                icon: Container(
                    height: size.height * 0.05,
                    child: Image.asset(
                      "asset/his.png",
                    )))
          ],
          leading: IconButton(
              onPressed: () {
                Provider.of<Controller>(context, listen: false)
                    .setstockTranserselected(false);
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) {
                          return MainDashboard();
                        }));
                // Navigator.pushReplacement<void, void>(
                //   context,
                //   MaterialPageRoute<void>(
                //       builder: (BuildContext context) => MainDashboard()),
                // );
                // Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: P_Settings.loginPagetheme),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          print("brName------${value.brName}");

          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 33, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Series  : ",
                            style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          value.series != null
                              ? Text(
                                  "${value.series}",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                )
                              : SpinKitThreeBounce(
                                  size: 10,
                                  color: P_Settings.loginPagetheme,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Text(
                              "Entry date  :  $todaydate",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold //<-- SEE HERE
                                  ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                customContainer(size, topInsets),
                Divider(),
                Container(
                  transform: Matrix4.translationValues(0.0, -7.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 140.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  "My Cart ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                value.cartCount == null
                                    ? SpinKitThreeBounce(
                                        color: P_Settings.loginPagetheme,
                                        size: 10,
                                      )
                                    : Text(
                                        "(${value.cartCount})",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            if (value.selected != null) {
                              value.searchList.clear();
                              value.searchcontroller.clear();
                              searchSheet.showsearchSheet(context, size,
                                  widget.form_type, value.selected!);
                            } else {
                              snackbar.showSnackbar(
                                  context, "Please Select Project ", "");
                            }
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.01,
                // ),
                value.isLoading
                    ? Container(
                        height: size.height * 0.5,
                        child: SpinKitCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : value.bagList.length == 0
                        ? Container(
                            height: size.height * 0.5,
                            child: Lottie.asset(
                              'asset/emptycart.json',
                              height: size.height * 0.24,
                              width: size.height * 0.23,
                            ))
                        : Container(
                            transform:
                                Matrix4.translationValues(0.0, -10.0, 0.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: value.bagList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Card(
                                      child: ListTile(
                                        leading: Container(
                                          // height: size.height*0.2,
                                          // width: size.width*0.2,
                                          child: CircleAvatar(
                                             radius: 25,
                                            backgroundImage:AssetImage('asset/noImg.png',),
                                            
                                          ),
                                        ),
                                        title: Text(
                                          "${value.bagList[index]['item_name']}",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              "Qty :",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.12,
                                              child: FocusScope(
                                                // onFocusChange: (valuess) {
                                                //   double valueqty = 0.0;
                                                //   if (valuess == false) {
                                                //     Provider.of<Controller>(
                                                //             context,
                                                //             listen: false)
                                                //         .addDeletebagItem(
                                                //             value.bagList[index]
                                                //                 ["item_id"],
                                                //             value.bagList[index]
                                                //                     ["s_rate_1"]
                                                //                 .toString(),
                                                //             value.bagList[index]
                                                //                     ["s_rate_2"]
                                                //                 .toString(),
                                                //             value
                                                //                 .t2qtycontroller[
                                                //                     index]
                                                //                 .text,
                                                //             "0",
                                                //             "0",
                                                //             context,
                                                //             "save",
                                                //             "transaction2");
                                                //   }
                                                // },
                                                child: TextField(
                                                  controller: value
                                                      .t2qtycontroller[index],
                                                  // autofocus: true,
                                                  onTap: () {
                                                    value.t2qtycontroller[index]
                                                            .selection =
                                                        TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset: value
                                                                .t2qtycontroller[
                                                                    index]
                                                                .value
                                                                .text
                                                                .length);
                                                  },

                                                  // autofocus: true,
                                                  style: GoogleFonts.aBeeZee(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    fontSize: 17,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey[600],
                                                  ),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    //border: InputBorder.none
                                                  ),

                                                  // maxLines: 1,
                                                  // minLines: 1,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onSubmitted: (values) {
                                                    double valueqty = 0.0;
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .addDeletebagItem(
                                                            value.bagList[index]
                                                                ["item_id"],
                                                            value.bagList[index]
                                                                    ["s_rate_1"]
                                                                .toString(),
                                                            value.bagList[index]
                                                                    ["s_rate_2"]
                                                                .toString(),
                                                            value
                                                                .t2qtycontroller[
                                                                    index]
                                                                .text,
                                                            "0",
                                                            "0",
                                                            context,
                                                            "edit",
                                                            "transaction2",
                                                            widget.form_type,
                                                            value.selected!);
                                                  },

                                                  textAlign: TextAlign.right,
                                                  // controller: value.qty[index],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                content: Text(
                                                    "Do you want to delete (${value.bagList[index]["item_name"]}) ???"),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () async {
                                                          Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                              value.bagList[
                                                                      index]
                                                                  ["item_id"],
                                                              value
                                                                  .bagList[index]
                                                                      [
                                                                      "s_rate_1"]
                                                                  .toString(),
                                                              value
                                                                  .bagList[index]
                                                                      [
                                                                      "s_rate_2"]
                                                                  .toString(),
                                                              value
                                                                  .t2qtycontroller[
                                                                      index]
                                                                  .text
                                                                  .toString(),
                                                              "2",
                                                              value.bagList[
                                                                      index]
                                                                  ["cart_id"],
                                                              context,
                                                              "delete",
                                                              "transaction2",
                                                              widget.form_type,
                                                              value.selected!);

                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Ok"),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.01,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )

                                    // Card(
                                    //   elevation: 2,
                                    //   child: ListTile(
                                    //     title: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: Column(
                                    //         children: [
                                    //           Text(
                                    //             "${value.bagList[index]['item_name']}",
                                    //             style: GoogleFonts.aBeeZee(
                                    //                 textStyle: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText2,
                                    //                 fontSize: 15,
                                    //                 fontWeight: FontWeight.bold,
                                    //                 color: P_Settings
                                    //                     .loginPagetheme),
                                    //           ),
                                    //           Padding(
                                    //             padding:
                                    //                 const EdgeInsets.only(top: 6),
                                    //             child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment
                                    //                       .spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   "SRate1 :\u{20B9}${value.bagList[index]["s_rate_1"]}",
                                    //                   style: GoogleFonts.aBeeZee(
                                    //                     textStyle:
                                    //                         Theme.of(context)
                                    //                             .textTheme
                                    //                             .bodyText2,
                                    //                     fontSize: 14,
                                    //                     color: Colors.grey[600],
                                    //                   ),
                                    //                 ),
                                    //                 // SizedBox(width: size.width * 0.032),
                                    //                 Text(
                                    //                   "SRate2 :\u{20B9}${value.bagList[index]["s_rate_2"]}",
                                    //                   style: GoogleFonts.aBeeZee(
                                    //                     textStyle:
                                    //                         Theme.of(context)
                                    //                             .textTheme
                                    //                             .bodyText2,
                                    //                     fontSize: 14,
                                    //                     color: Colors.grey[600],
                                    //                   ),
                                    //                 ),

                                    //                 Row(
                                    //                   children: [
                                    //                     Text(
                                    //                       "Qty :",
                                    //                       style:
                                    //                           GoogleFonts.aBeeZee(
                                    //                         textStyle:
                                    //                             Theme.of(context)
                                    //                                 .textTheme
                                    //                                 .bodyText2,
                                    //                         fontSize: 14,
                                    //                         color:
                                    //                             Colors.grey[600],
                                    //                       ),
                                    //                     ),
                                    //                     Container(
                                    //                       width:
                                    //                           size.width * 0.12,
                                    //                       child: FocusScope(
                                    //                         // onFocusChange: (valuess) {
                                    //                         //   double valueqty = 0.0;
                                    //                         //   if (valuess == false) {
                                    //                         //     Provider.of<Controller>(
                                    //                         //             context,
                                    //                         //             listen: false)
                                    //                         //         .addDeletebagItem(
                                    //                         //             value.bagList[index]
                                    //                         //                 ["item_id"],
                                    //                         //             value.bagList[index]
                                    //                         //                     ["s_rate_1"]
                                    //                         //                 .toString(),
                                    //                         //             value.bagList[index]
                                    //                         //                     ["s_rate_2"]
                                    //                         //                 .toString(),
                                    //                         //             value
                                    //                         //                 .t2qtycontroller[
                                    //                         //                     index]
                                    //                         //                 .text,
                                    //                         //             "0",
                                    //                         //             "0",
                                    //                         //             context,
                                    //                         //             "save",
                                    //                         //             "transaction2");
                                    //                         //   }
                                    //                         // },
                                    //                         child: TextField(
                                    //                           controller: value
                                    //                                   .t2qtycontroller[
                                    //                               index],
                                    //                           // autofocus: true,
                                    //                           onTap: () {
                                    //                             value
                                    //                                     .t2qtycontroller[
                                    //                                         index]
                                    //                                     .selection =
                                    //                                 TextSelection(
                                    //                                     baseOffset:
                                    //                                         0,
                                    //                                     extentOffset: value
                                    //                                         .t2qtycontroller[
                                    //                                             index]
                                    //                                         .value
                                    //                                         .text
                                    //                                         .length);
                                    //                           },

                                    //                           // autofocus: true,
                                    //                           style: GoogleFonts
                                    //                               .aBeeZee(
                                    //                             textStyle: Theme.of(
                                    //                                     context)
                                    //                                 .textTheme
                                    //                                 .bodyText2,
                                    //                             fontSize: 17,
                                    //                             // fontWeight: FontWeight.bold,
                                    //                             color: Colors
                                    //                                 .grey[600],
                                    //                           ),
                                    //                           decoration:
                                    //                               InputDecoration(
                                    //                             isDense: true,
                                    //                             contentPadding:
                                    //                                 EdgeInsets
                                    //                                     .all(0),
                                    //                             //border: InputBorder.none
                                    //                           ),

                                    //                           // maxLines: 1,
                                    //                           // minLines: 1,
                                    //                           keyboardType:
                                    //                               TextInputType
                                    //                                   .number,
                                    //                           onSubmitted:
                                    //                               (values) {
                                    //                             double valueqty =
                                    //                                 0.0;
                                    //                             Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                    //                                 value.bagList[
                                    //                                         index][
                                    //                                     "item_id"],
                                    //                                 value.bagList[
                                    //                                         index][
                                    //                                         "s_rate_1"]
                                    //                                     .toString(),
                                    //                                 value.bagList[
                                    //                                         index]
                                    //                                         [
                                    //                                         "s_rate_2"]
                                    //                                     .toString(),
                                    //                                 value
                                    //                                     .t2qtycontroller[
                                    //                                         index]
                                    //                                     .text,
                                    //                                 "0",
                                    //                                 "0",
                                    //                                 context,
                                    //                                 "edit",
                                    //                                 "transaction2",
                                    //                                 widget
                                    //                                     .form_type,
                                    //                                 value
                                    //                                     .selected!);
                                    //                           },

                                    //                           textAlign:
                                    //                               TextAlign.right,
                                    //                           // controller: value.qty[index],
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           Divider(),
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               print(
                                    //                   "value.vvbagList------------${value.bagList}");

                                    //               showDialog(
                                    //                 context: context,
                                    //                 builder: (ctx) => AlertDialog(
                                    //                   content: Text(
                                    //                       "Do you want to delete (${value.bagList[index]["item_name"]}) ???"),
                                    //                   actions: <Widget>[
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                           MainAxisAlignment
                                    //                               .end,
                                    //                       children: [
                                    //                         ElevatedButton(
                                    //                           style: ElevatedButton
                                    //                               .styleFrom(
                                    //                                   primary:
                                    //                                       P_Settings
                                    //                                           .loginPagetheme),
                                    //                           onPressed:
                                    //                               () async {
                                    //                             Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                    //                                 value.bagList[index]
                                    //                                     [
                                    //                                     "item_id"],
                                    //                                 value.bagList[
                                    //                                         index]
                                    //                                         [
                                    //                                         "s_rate_1"]
                                    //                                     .toString(),
                                    //                                 value.bagList[
                                    //                                         index]
                                    //                                         [
                                    //                                         "s_rate_2"]
                                    //                                     .toString(),
                                    //                                 value
                                    //                                     .t2qtycontroller[
                                    //                                         index]
                                    //                                     .text
                                    //                                     .toString(),
                                    //                                 "2",
                                    //                                 value.bagList[
                                    //                                         index]
                                    //                                     ["cart_id"],
                                    //                                 context,
                                    //                                 "delete",
                                    //                                 "transaction2",
                                    //                                 widget.form_type,
                                    //                                 value.selected!);

                                    //                             Navigator.of(ctx)
                                    //                                 .pop();
                                    //                           },
                                    //                           child: Text("Ok"),
                                    //                         ),
                                    //                         SizedBox(
                                    //                           width: size.width *
                                    //                               0.01,
                                    //                         ),
                                    //                         ElevatedButton(
                                    //                           style: ElevatedButton
                                    //                               .styleFrom(
                                    //                                   primary:
                                    //                                       P_Settings
                                    //                                           .loginPagetheme),
                                    //                           onPressed: () {
                                    //                             Navigator.of(ctx)
                                    //                                 .pop();
                                    //                           },
                                    //                           child:
                                    //                               Text("Cancel"),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               );
                                    //             },
                                    //             child: Row(
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons.close,
                                    //                   color: Colors.red,
                                    //                 ),
                                    //                 Text(
                                    //                   "Remove",
                                    //                   style: GoogleFonts.aBeeZee(
                                    //                       textStyle:
                                    //                           Theme.of(context)
                                    //                               .textTheme
                                    //                               .bodyText2,
                                    //                       fontSize: 15,
                                    //                       fontStyle:
                                    //                           FontStyle.italic,
                                    //                       // fontWeight: FontWeight.bold,
                                    //                       color:
                                    //                           Colors.grey[700]),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    );
                              },
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget dropDownSite(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.height * 0.41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 0.5),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: value.selected,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "select project",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,
              items: value.siteList
                  .map((item) => DropdownMenuItem<String>(
                      value: item["UID"],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item["branch"].toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                FocusScope.of(context).requestFocus(new FocusNode());

                print("clicked");
                if (item != null) {
                  setState(() {
                    value.selected = item;
                  });
                  Provider.of<Controller>(context, listen: false).getbagData1(
                    context,
                    "main",
                    "",
                    widget.form_type,
                    value.selected!,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget customContainer(Size size, topInsets) {
    return Container(
      transform: Matrix4.translationValues(0.0, -8.0, 0.0),
      child: Column(
        children: [
          dropDownSite(size),
          Container(
            width: size.height * 0.41,
            child: TextFormField(
              controller: remrk,
              scrollPadding:
                  EdgeInsets.only(bottom: topInsets + size.height * 0.34),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.note_add,
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                // focusedErrorBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(25)),
                //   borderSide: BorderSide(
                //     width: 1,
                //     color: Colors.red,
                //   ),
                // ),
                // errorBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //     borderSide: BorderSide(
                //       width: 1,
                //       color: Colors.red,
                //     )),
                hintStyle: GoogleFonts.aBeeZee(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                hintText: "Enter remark",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

showDailogue(BuildContext context, bool isLoading, GlobalKey key, int content) {
  return showDialog(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;

        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.white,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Loading .... ",
                            style: TextStyle(color: Colors.black),
                          ),
                          CircularProgressIndicator(
                            color: Colors.green,
                          )
                        ]),
                  )
                ]));
      });
}
