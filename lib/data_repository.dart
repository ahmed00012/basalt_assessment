import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class DataRepository {
  Future getData({String ?dateFrom,String ?dateTo,String? search});
}

class DataRepo extends DataRepository{
  @override
  Future getData({String ?dateFrom,String ?dateTo,String? search}) async{
    try{
      var response = await http.get(Uri.parse('http://api.marketstack.com/v1/tickers?access_key=5e0ba68295248fd1d81f1ac8d0bccc1d&'
          'date_from=${dateFrom??''}& date_to=${dateTo??''}&symbols=AAPL,MSFT,GOOGL,BABA,FB,VOD,JPM,TSM,INTC,DIS&search${search??''}'
          ));

      var data = json.decode(response.body);
      print(data);

      if(response.statusCode==200){
        return data['data'];
      }
      else{
        return data['error']['message'];
      }

    }
    catch(e){
      return throw e.toString();
    }
  }


}

