import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

var userAgent = 'Scribbly/0.1';
var baseUrl = 'https://www.scribblehub.com/series/';

Future<HtmlDocument> scrapePage(String url) async {
  var uri = Uri.parse(url);
  var response = await http.get(uri, headers: {'User-Agent': userAgent});

  return parseHtmlDocument(response.body);
}

Future<HtmlDocument> scrapeChapterList(String url, int novelId) async {
  var uri = Uri.parse(url);
  var response = await http.post(
    uri,
    headers: {'User-Agent': userAgent},
    body: {
      'action': 'wi_getreleases_pagination',
      'pagenum': '-1',
      'mypostid': novelId.toString()
    },
  );

  return parseHtmlDocument(response.body);
}
