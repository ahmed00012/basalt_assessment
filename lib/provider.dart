
import 'package:basalt_assessment/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_model.dart';

final dataFuture =
ChangeNotifierProvider.autoDispose<DataProvider>((ref) => DataProvider());
class DataProvider extends ChangeNotifier {
  DataRepo dataRepo = DataRepo();
  List<DataModel> data  = [];



DataProvider(){
  getData();
}


  getData({String? dateFrom,String? dateTo,String? search})async{
  data=[];
  notifyListeners();
    var response = await dataRepo.getData(dateFrom:dateFrom, dateTo:dateTo,search: search);
    data = List.from(response.map((e) => DataModel.fromJson(e)));
    data.insert(0, DataModel(
      name: 'Name',
      symbol: 'Symbol',
      stockExchange: StockExchange(
        name: 'Stock Exchange',
        country: 'Country',
        mic: 'Stock Exchange (MIC)'
      )
    ));
    notifyListeners();
  }

  Future pickDateRange(BuildContext context) async {
    await showDateRangePicker(
      context: context,
      // initialDateRange: dateRange,
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
            ),
          ),
          child: Container(
            height: 200,
            width: 200,
            child: child!,
          ),
        );
      },

    ).then((value) => print(value.toString()));

  }


}