import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class DataRepository {
  Future getData({String ?dateFrom,String ?dateTo,String? search});
}

class DataRepo extends DataRepository{
  @override
  Future getData({String ?dateFrom,String ?dateTo,String? search}) async{
   List<String> symbols = ['AAPL','MSFT','GOOGL','BABA','FB','VOD','JPM','TSM','INTC','DIS'];
   List<String> symbols2 = [];

   symbols.forEach((element) {
     if(element==search.toString()){
       symbols2.add(element);
     }
   });
   if(search==null||search==''){
     symbols2=List.from(symbols);
   }
   String finalSymbols = symbols2.toString().replaceAll(']', '').replaceAll('[', '').replaceAll(' ', '');


    try{
      var response = await http.get(Uri.parse('http://api.marketstack.com/v1/tickers?access_key=cc6a13b9a7f35dd0897b92e79127b8a1&'
          'date_from=${dateFrom??''}& date_to=${dateTo??''}&symbols=$finalSymbols'
          ));

      var data = json.decode(response.body);
      print(data);
      print(search);
      print(dateFrom);
      print(dateTo);
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

