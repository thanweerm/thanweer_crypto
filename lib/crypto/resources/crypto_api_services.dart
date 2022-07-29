import 'package:cryptonew/crypto/models/crypto_model.dart';
import 'package:http/http.dart';

class CryptoApiServices {
  final url =
      "https://cryptopanic.com/api/v1/posts/?auth_token=a2885be00888eb15621a51ea39be1171040b85ed&public=true";
// to get the news datas from crypto url
  Future<Reminder> getCryptoNews(apiname) async {
    final response = await get(Uri.parse('${url}&page=$apiname'));
    final cryptoNews = reminderFromJson(response.body);

    return cryptoNews;
  }
}
