// import 'package:azlistview/azlistview.dart';
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hamco/components/commonColor.dart';
// import 'package:hamco/controller/controller.dart';
// import 'package:hamco/screen/bottomSheet/bottomSheetModal.dart';
// import 'package:hamco/screen/bottomSheet/infoBottomsheet.dart';

// import 'package:provider/provider.dart';

// class ItemSelection extends StatefulWidget {
//   List<Map<String, dynamic>> list;
//   int transVal;
//   String transType;
//   String page;
//   String? hint;
//   String form_type;

//   ItemSelection(
//       {required this.list,
//       required this.transVal,
//       required this.transType,
//       required this.page,
//       required this.form_type,
//       this.hint});

//   @override
//   State<ItemSelection> createState() => _ItemSelectionState();
// }

// class _ItemSelectionState extends State<ItemSelection> {
//   String? selected;
//   String? selecteditem;

//   String? hint;
//   List splitted = [];
//   List<_AZItem> items = [];
//   List<String> uniqueList = [];
//   Bottomsheet showsheet = Bottomsheet();
//   InfoBottomsheet infoshowsheet = InfoBottomsheet();
//   String? staff_id;
//   var itemstest = [
//     'kg',
//     'pcs',
//   ];
//   // List<String> items = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("dgjxfkjgkg-----${widget.list}");
//     // hint = Provider.of<Controller>(context, listen: false).dropdwnVal;
//     // hint = widget.hint;
//     print("nzkjnjkdzfn----$hint");
//     initList(widget.list);
//   }

// /////////////////////////////////////
//   void initList(List<Map<String, dynamic>> items) {
//     print("cjncn----${items}");
//     this.items = items
//         .map(
//           (item) => _AZItem(
//             tag: item["item_name"][0].toUpperCase(),
//             itemId: item["item_id"],
//             catId: item["cat_id"],
//             itemName: item["item_name"].toUpperCase(),
//             batchCode: item["batch_code"],
//             itemImg: item["item_img"],
//             sRate1: item["s_rate_1"],
//             sRate2: item["s_rate_2"],
//             stock: item["stock"],
//           ),
//         )
//         .toList();
//     SuspensionUtil.sortListBySuspensionTag(this.items);
//     SuspensionUtil.setShowSuspensionStatus(this.items);
//     setState(() {});
//   }

//   // void setBarData(List<Map<String, dynamic>> items) {
//   //   print("cjncn----${items}");
//   //   this.items = items
//   //       .map(
//   //         (item) => _AZItem(
//   //           title: item["item"].toUpperCase(),
//   //           tag: item["item"][0].toUpperCase(),
//   //         ),
//   //       )
//   //       .toList();
//   //   SuspensionUtil.sortListBySuspensionTag(this.items);
//   //   SuspensionUtil.setShowSuspensionStatus(this.items);
//   //   setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(

//         // appBar: AppBar(
//         //   leading: IconButton(
//         //       onPressed: () {
//         //         Provider.of<Controller>(context, listen: false)
//         //             .setfilter(false);
//         //         Navigator.pop(context);
//         //       },
//         //       icon: Icon(Icons.arrow_back)),
//         //   backgroundColor: P_Settings.loginPagetheme,
//         // ),
//         body: Consumer<Controller>(
//       builder: (context, value, child) {
//         // selected="dkjszdnkj";
//         print("value.dropdwn-------${value.dropdwnString}");
//         if (value.isLoading) {
//           return SpinKitFadingCircle(
//             color: P_Settings.loginPagetheme,
//           );
//         } else {
//           return Column(
//             children: [
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: Text(
//               //     "Select Item Category",
//               //     style: TextStyle(fontSize: 20),
//               //   ),
//               // ),
//               // Divider(),
//               SizedBox(
//                 height: size.height * 0.02,
//               ),
//               Container(
//                 width: size.width * 0.9,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   border: Border.all(
//                       color: P_Settings.loginPagetheme,
//                       style: BorderStyle.solid,
//                       width: 0.3),
//                 ),
//                 child: DropdownButton<String>(
//                   isExpanded: true,
//                   value: selected,
//                   // value: selected,
//                   // isDense: true,
//                   hint: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(value.dropdwnString == null ||
//                             value.dropdwnString!.isEmpty
//                         ? value.dropdwnVal.toString()
//                         : value.dropdwnString.toString()),
//                   ),
//                   // isExpanded: true,
//                   autofocus: false,
//                   underline: SizedBox(),
//                   elevation: 0,
//                   items: value.itemCategoryList
//                       .map((item) => DropdownMenuItem<String>(
//                           value: "${item.catId},${item.catName}",
//                           child: Container(
//                             width: size.width * 0.9,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 item.catName.toString(),
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           )))
//                       .toList(),
//                   onChanged: (item) {
//                     print("clicked");
//                     if (item != null) {
//                       setState(() {
//                         selected = item;
//                       });
//                       splitted = selected!.split(',');
//                       print("splitted---$splitted");
//                       // Provider.of<Controller>(context, listen: false)
//                       //     .filterProduct(selected!);
//                       print("se;ected---$item");
//                     }
//                     Provider.of<Controller>(context, listen: false)
//                         .getProductDetails(splitted[0], splitted[1]);
//                   },
//                 ),
//               ),
//               Divider(),
//               Expanded(child: Consumer<Controller>(
//                 builder: (context, value, child) {
//                   print("value------${value.filter}");
//                   return AzListView(
//                     data: items,
//                     itemCount: items.length,
//                     itemBuilder: (context, index) {
//                       final item = items[index];
//                       print("itemmmm------$item");
//                       return buildListitem(item, size, index);
//                     },
//                     indexHintBuilder: (context, tag) {
//                       return Container(
//                         alignment: Alignment.center,
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                             color: Colors.blue, shape: BoxShape.circle),
//                         child: Text(
//                           tag,
//                           style: TextStyle(color: Colors.white, fontSize: 50),
//                         ),
//                       );
//                     },
//                     indexBarMargin: EdgeInsets.all(10),
//                     indexBarAlignment: Alignment.centerLeft,
//                     indexBarItemHeight: 30,
//                     indexBarData: value.uniquelist,
//                     indexBarOptions: IndexBarOptions(
//                       needRebuild: true,
//                       selectTextStyle: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                       selectItemDecoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.blue),
//                       indexHintAlignment: Alignment.centerRight,
//                       indexHintOffset: Offset(-20, 0),
//                     ),
//                   );
//                 },
//               ))
//               // Expanded(
//               //   child: AlphabetScrollPage(
//               //       onClickedItem: (item) {
//               //         final snackbar = SnackBar(
//               //             content: Text(
//               //           "Clicked Item  $item",
//               //           style: TextStyle(fontSize: 20),
//               //         ));
//               //         ScaffoldMessenger.of(context)
//               //           ..removeCurrentSnackBar()
//               //           ..showSnackBar(snackbar);
//               //       },
//               //       items: value.filter
//               //           ? value.filteredproductList
//               //           : widget.list),
//               // ),
//             ],
//           );
//         }
//       },
//     ));
//   }

//   Widget buildListitem(_AZItem item, Size size, int index) {
//     // final tag = item.getSuspensionTag();
//     final offStage = item.isShowSuspension;
//     return Column(
//       children: [
//         // Offstage(offstage: offStage, child: buildHeader(tag)),
//         Consumer<Controller>(
//           builder: (context, value, child) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(width: 1, color: Colors.grey),
//                 ),
//               ),
//               // height: size.height * 0.08,
//               margin: EdgeInsets.only(left: 40),
//               child: ListTile(
//                 trailing: Wrap(
//                   children: [
//                     value.qty[index].text == "0"
//                         ? GestureDetector(
//                             onTap: () {
//                               value.setqtyErrormsg(false);
//                               value.qty[index].selection = TextSelection(
//                                   baseOffset: 0,
//                                   extentOffset:
//                                       value.qty[index].value.text.length);
//                               showsheet.showSheet(
//                                   context,
//                                   index,
//                                   item.itemId!,
//                                   item.catId!,
//                                   item.batchCode!,
//                                   item.itemName!,
//                                   item.itemImg!,
//                                   double.parse(item.sRate1!),
//                                   double.parse(item.sRate2!),
//                                   double.parse(item.stock!),
//                                   widget.transVal,
//                                   value.qty[index].text,
//                                   item.itemImg!,
//                                   widget.form_type);
//                             },
//                             child: Container(
//                                 width: size.width * 0.05,
//                                 child: Icon(Icons.add)),
//                           )
//                         //  IconButton(
//                         //     onPressed: () {
//                         //       // int qty;
//                         //       value.setqtyErrormsg(false);
//                         //       value.qty[index].selection = TextSelection(
//                         //           baseOffset: 0,
//                         //           extentOffset:
//                         //               value.qty[index].value.text.length);
//                         //       showsheet.showSheet(
//                         //           context,
//                         //           index,
//                         //           item.itemId!,
//                         //           item.catId!,
//                         //           item.batchCode!,
//                         //           item.itemName!,
//                         //           item.itemImg!,
//                         //           double.parse(item.sRate1!),
//                         //           double.parse(item.sRate2!),
//                         //           double.parse(item.stock!),
//                         //           widget.transVal,
//                         //           value.qty[index].text,
//                         //           item.itemImg!);
//                         //     },
//                         //     icon: Icon(
//                         //       Icons.add,
//                         //       size: 20,
//                         //     ))
//                         : GestureDetector(
//                             onTap: () {
//                               value.setqtyErrormsg(false);
//                               value.qty[index].selection = TextSelection(
//                                   baseOffset: 0,
//                                   extentOffset:
//                                       value.qty[index].value.text.length);
//                               showsheet.showSheet(
//                                   context,
//                                   index,
//                                   item.itemId!,
//                                   item.catId!,
//                                   item.batchCode!,
//                                   item.itemName!,
//                                   item.itemImg!,
//                                   double.parse(item.sRate1!),
//                                   double.parse(item.sRate2!),
//                                   double.parse(item.stock!),
//                                   widget.transVal,
//                                   value.qty[index].text,
//                                   item.itemImg!,
//                                   widget.form_type);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 0,
//                               ),
//                               child: Text(
//                                 value.qty[index].text,
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),

//                 title: Text(item.itemName!,
//                     // overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.aBeeZee(
//                       textStyle: Theme.of(context).textTheme.bodyText2,
//                       fontSize: 16,
//                       // fontWeight: FontWeight.bold,
//                       color: P_Settings.loginPagetheme,
//                     )),
//                 subtitle: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(width: size.width * 0.2, child: Text("MOP")),
//                         Container(width: size.width * 0.2, child: Text(" MRP")),
//                         Container(
//                             width: size.width * 0.11, child: Text(" Stock")),
//                         GestureDetector(
//                           onTap: () {
//                             Provider.of<Controller>(context, listen: false)
//                                 .getinfoList(context, item.itemId!);
//                             infoshowsheet.showInfoSheet(
//                               context,
//                             );
//                           },
//                           child: Icon(
//                             Icons.info,
//                             size: 19,
//                           ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                             width: size.width * 0.2,
//                             child: Text("${item.sRate1}")),
//                         Container(
//                             width: size.width * 0.2,
//                             child: Text("${item.sRate2}")),
//                         Container(
//                             width: size.width * 0.1,
//                             child: Text("${item.stock}")),
//                         Icon(
//                           Icons.info,
//                           size: 19,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     //   children: [
//                     //     Flexible(
//                     //       child: Container(
//                     //           // width: size.width * 0.,
//                     //           child: Text("MOP:${item.sRate1},")),
//                     //     ),
//                     //     Flexible(
//                     //       child: Container(
//                     //           // width: size.width * 0.3,
//                     //           child: Text(" MRP:${item.sRate2},")),
//                     //     ),
//                     //     Flexible(
//                     //       child: Container(
//                     //           // width: size.width * 0.3,
//                     //           child: Text(" Stock:${item.stock}")),
//                     //     ),
//                     //     GestureDetector(
//                     //       onTap: () {
//                     //         Provider.of<Controller>(context, listen: false)
//                     //             .getinfoList(context, item.itemId!);
//                     //         infoshowsheet.showInfoSheet(
//                     //           context,
//                     //         );
//                     //       },
//                     //       child: Icon(
//                     //         Icons.info,
//                     //         size: 19,
//                     //       ),
//                     //     )
//                     //   ],
//                     // ),
//                   ],
//                 ),
//                 // onTap: () {
//                 //   value.setqtyErrormsg(false);

//                 //   showsheet.showSheet(
//                 //       context,
//                 //       index,
//                 //       item.itemId!,
//                 //       item.catId!,
//                 //       item.batchCode!,
//                 //       item.itemName!,
//                 //       item.itemImg!,
//                 //       double.parse(item.sRate1!),
//                 //       double.parse(item.sRate2!),
//                 //       double.parse(item.stock!),
//                 //       widget.transVal,
//                 //       value.qty[index].text);
//                 // }
//                 // widget.onClickedItem(item.title!),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildHeader(String tag) {
//     return Container(
//       height: 40,
//       margin: EdgeInsets.only(right: 18),
//       padding: EdgeInsets.only(left: 18),
//       color: Colors.grey,
//       alignment: Alignment.centerLeft,
//       child: Text(
//         "$tag",
//         // softWrap: false,
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

// class _AZItem extends ISuspensionBean {
//   String? tag;
//   String? itemId;
//   String? catId;
//   String? itemName;
//   String? batchCode;
//   String? itemImg;
//   String? sRate1;
//   String? sRate2;
//   String? stock;

//   _AZItem({
//     this.tag,
//     this.itemId,
//     this.catId,
//     this.itemName,
//     this.batchCode,
//     this.itemImg,
//     this.sRate1,
//     this.sRate2,
//     this.stock,
//   });

//   @override
//   String getSuspensionTag() => tag!;
// }
