import 'package:flutter/material.dart';
import 'package:scribbly/theme.dart';
import 'package:scribbly/types/author.dart';
import 'package:scribbly/types/novel.dart';
import 'package:scribbly/utils/scraper/author.dart';
import 'package:scribbly/widgets/error_screen.dart';
import 'package:scribbly/widgets/result_card.dart';

class AuthorPage extends StatelessWidget {
  const AuthorPage({Key? key, required this.id}) : super(key: key);

  final int id;

  Future<AuthorData> _getAuthorData() async {
    final result = await Future.wait([getAuthorData(id), getAuthorNovels(id)]);

    return AuthorData(
        details: result[0] as AuthorDetails,
        novels: result[1] as List<NovelResult>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthorData>(
      future: _getAuthorData(),
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.hasData
                  ? snapshot.data!.details.username
                  : 'Author'),
            ),
            body: Builder(
              builder: (context) {
                if (snapshot.hasError) {
                  return const Center(child: ErrorScreen());
                } else if (snapshot.hasData) {
                  return _buildAuthorData(snapshot.data!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ));
      },
    );
  }

  Widget _buildAuthorData(AuthorData data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAuthorCard(data.details),
          _buildNovelList(data.novels),
        ],
      ),
    );
  }

  Widget _buildAuthorCard(AuthorDetails author) {
    return Card(
      margin: cardMargin,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (author.avatarUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    author.avatarUrl!,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  author.username,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              if (author.about != null && author.about!.isNotEmpty)
                _buildAbout(author.about!)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNovelList(List<NovelResult> novels) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: novels.length,
        itemBuilder: (context, index) => ResultCard(data: novels[index]));
  }

  Widget _buildAbout(String about) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(about.replaceAll('\n', '\n\n').trim()));
  }
}
