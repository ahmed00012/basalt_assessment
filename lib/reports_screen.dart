import 'package:basalt_assessment/data_model.dart';
import 'package:basalt_assessment/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Reports extends ConsumerWidget {

  final DateRangePickerController dateController = DateRangePickerController();
  TextEditingController search = TextEditingController();



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final controller = ref.watch(dataFuture);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [

           SizedBox(height: height*0.08,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,),

            child: Container(
              // height: height*0.05,
              // width: size.width*0.9,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(

                  onChanged: (value){
                    // homeController.searchExpected(value);
                  },

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon:  InkWell(
                      onTap: (){
                        controller.getData(search: search.text);
                        search.text='';
                      },
                      child: Container(
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )
                        ),
                        child: Center(
                          child: Icon(Icons.search,color: Colors.white,),
                        ),
                      ),
                    ),

                    hintText: '  Search By Name Or Symbol',
                    hintStyle: TextStyle(color: Colors.black26),



                  ),
                  onEditingComplete: (){
                    controller.getData(search: search.text);
                    search.text='';
                  },
                  enableInteractiveSelection:false

              ),
            ),
          ),
          SizedBox(height: height*0.05,),
      Center(child: Text('Filter By Date')),

          SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          controller: dateController,
          selectionMode: DateRangePickerSelectionMode.range,
          minDate: DateTime(2005),
          maxDate: DateTime.now(),
          onSubmit: (value){
             controller.getData(dateFrom:dateController.selectedRange!.startDate.toString().substring(0,10),
               dateTo:  dateController.selectedRange!.endDate.toString().substring(0,10),);
          },

          // endRangeSelectionColor: Colors.black,
          // startRangeSelectionColor: Colors.black,
          // rangeSelectionColor: Colors.black12,
          backgroundColor: Colors.white,
          showActionButtons: true,

        ),
      ),

          SizedBox(height: height*0.08,),
          Expanded(
            child:   SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                  border: TableBorder.symmetric(inside: BorderSide(width: 1)),


                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: IntrinsicColumnWidth(),
                    2: IntrinsicColumnWidth(),
                    3: IntrinsicColumnWidth(),
                    4: IntrinsicColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FlexColumnWidth(64),
                  },


                  children: controller.data.map((e) {
                    int i = controller.data.indexOf(e);
                    return TableRow(
                        children: [
                          Container(
                            height: height*0.07,
                            color: i==0||i%2==0?Colors.black12:Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(child: Text(e.symbol!,style: TextStyle(
                                fontWeight:i==0? FontWeight.bold:FontWeight.normal
                            ),)),
                          ),
                          Container(
                            height: height*0.07,
                            color: i==0||i%2==0?Colors.black12:Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(child: Text(e.name!,style: TextStyle(
                                fontWeight:i==0? FontWeight.bold:FontWeight.normal
                            ),)),
                          ),
                          Container(
                              height: height*0.07,
                              color: i==0||i%2==0?Colors.black12:Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(child: Text(e.stockExchange!.name!,style: TextStyle(
                                  fontWeight:i==0? FontWeight.bold:FontWeight.normal
                              ),))),
                          Container(
                              height: height*0.07,
                              color: i==0||i%2==0?Colors.black12:Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(child: Text(e.stockExchange!.mic!,style: TextStyle(
                                  fontWeight:i==0? FontWeight.bold:FontWeight.normal
                              ),))),
                          Container(
                              height: height*0.07,
                              color: i==0||i%2==0?Colors.black12:Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(child: Text(e.stockExchange!.country!,style: TextStyle(
                                  fontWeight:i==0? FontWeight.bold:FontWeight.normal
                              ),))),
                        ]
                    );
                  }).toList()

              ),
            ),
          ),
        ],
      )
    );
  }
}
