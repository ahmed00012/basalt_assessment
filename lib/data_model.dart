class DataModel {
  String? name;
  String? symbol;
  StockExchange? stockExchange;

  DataModel({this.name, this.symbol, this.stockExchange});

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    stockExchange = json['stock_exchange'] != null
        ? new StockExchange.fromJson(json['stock_exchange'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    if (this.stockExchange != null) {
      data['stock_exchange'] = this.stockExchange!.toJson();
    }
    return data;
  }
}

class StockExchange {
  String? name;
  String? acronym;
  String? mic;
  String? country;
  String? countryCode;
  String? city;
  String? website;
  Timezone? timezone;

  StockExchange(
      {this.name,
        this.acronym,
        this.mic,
        this.country,
        this.countryCode,
        this.city,
        this.website,
        this.timezone});

  StockExchange.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    acronym = json['acronym'];
    mic = json['mic'];
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    website = json['website'];
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['acronym'] = this.acronym;
    data['mic'] = this.mic;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['website'] = this.website;
    if (this.timezone != null) {
      data['timezone'] = this.timezone!.toJson();
    }
    return data;
  }
}

class Timezone {
  String? timezone;
  String? abbr;
  String? abbrDst;

  Timezone({this.timezone, this.abbr, this.abbrDst});

  Timezone.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    abbr = json['abbr'];
    abbrDst = json['abbr_dst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['abbr'] = this.abbr;
    data['abbr_dst'] = this.abbrDst;
    return data;
  }
}
