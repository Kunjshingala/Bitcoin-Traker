import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'INR',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = "https://rest.coinapi.io/v1/exchangerate";
const apikey = "8A9287D6-AB58-4AEF-AD48-75B8F76EE32A";

//OLD "B04D3611-B390-46A2-A72D-47983D432408"
//NEW "8A9287D6-AB58-4AEF-AD48-75B8F76EE32A"

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apikey';
      Uri url = Uri.parse(requestURL);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        var lastPrice = decodeData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    print(cryptoPrices);
    return cryptoPrices;
  }
}
