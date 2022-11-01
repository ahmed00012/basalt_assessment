
import 'dart:async';
import 'package:overlay_support/overlay_support.dart';
import 'package:basalt_assessment/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_model.dart';

final dataFuture =
ChangeNotifierProvider.autoDispose<DataProvider>((ref) => DataProvider());
class DataProvider extends ChangeNotifier {
  DataRepo dataRepo = DataRepo();
  List<DataModel> data  = [];


  bool status = true;


DataProvider(){
  getData();
}


  getData({String? dateFrom,String? dateTo,String? search})async{
  data=[];
  notifyListeners();
  try {
    var response = await dataRepo.getData(
        dateFrom: dateFrom, dateTo: dateTo, search: search);
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
  }
  catch(e){
    showSimpleNotification(
        Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Text(
                e.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        duration: Duration(seconds: 3),
        elevation: 2,
        background: Colors.red );
  }
    notifyListeners();
  }



}