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

Future<HtmlDocument> scrapePost(Map<String, String> body) async {
  var uri = Uri.parse('https://www.scribblehub.com/wp-admin/admin-ajax.php');
  var response =
      await http.post(uri, headers: {'User-Agent': userAgent}, body: body);

  return parseHtmlDocument(response.body);
}

Map<String, String> buildAuthorNovelsRequestBody(int authorId) {
  return {
    'action': 'wi_perseries',
    'pagenum': '1',
    'intAuthorID': authorId.toString(),
    'isMobile': ''
  };
}

Map<String, String> buildChapterListRequestBody(int novelId) {
  return {
    'action': 'wi_getreleases_pagination',
    'pagenum': '-1',
    'mypostid': novelId.toString()
  };
}
