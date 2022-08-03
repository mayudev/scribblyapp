import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

Future<HtmlDocument> scrapePage(String url) async {
  var uri = Uri.parse(url);
  var response = await http.get(uri, headers: {'User-Agent': 'Scribbly/0.1'});

  return parseHtmlDocument(response.body);
}
