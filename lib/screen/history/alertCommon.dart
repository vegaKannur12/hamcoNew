import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamco/controller/controller.dart';

import 'package:provider/provider.dart';

import '../../components/commonColor.dart';



class AlertCommon {
  Future buildPopupDialog(BuildContext context, Size size, 
      int index, String todaydate,String form_type) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            content: Text("Do you want to delete???"),
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
                          print("heloooooooooooooooo");

                          // Provider.of<Controller>(context, listen: false)
                          //     .saveCartDetails(
                          //         ctx,
                          //         splitted[0],
                          //         value.historyList[index]['to_branch_id'],
                          //         value.historyList[index]['trans_remark'],
                          //         "2",
                          //         value.historyList[index]['os_id'],
                          //         "delete","transaction1");
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

                          //////////////////////////////////////////////////

                          await Provider.of<Controller>(context, listen: false)
                              .historyData(context,  "", df, tf,form_type);

                          // Navigator.of(ctx).pop();
                        },
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
}
