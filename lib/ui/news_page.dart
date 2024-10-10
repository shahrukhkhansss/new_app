import 'package:flutter/material.dart';
import 'package:news_app_api/ui/details_page.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../models/model.dart';
import '../providers/menu_data_provider.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  TextEditingController _searchController = TextEditingController();
  String queryInput = "technology";

  @override
  Widget build(BuildContext context) {
    var userDataProvider = Provider.of<menuDataProvider>(context);
    var apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Latest News'),
              onTap: () {
                // Handle navigation to latest news
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to settings
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Search Field
            TextField(
              controller: _searchController,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      queryInput = _searchController.text;
                    });
                  },
                ),
              ),
              onSubmitted: (String value) {
                setState(() {
                  queryInput = value;
                });
              },
            ),
            SizedBox(height: 10),
            // News List
            Expanded(
              child: FutureBuilder(
                future: apiService.getNews(queryInput),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    var data = snapshot.data;
                    List articles = data["articles"];
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        var article = Articles.fromJson(articles[index]);
                        return NewsListItem(
                          article: article,
                          onTap: () {
                            userDataProvider.Detailspage(article);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsListItem extends StatelessWidget {
  final Articles article;
  final VoidCallback onTap;

  NewsListItem({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        InkWell(
          onTap: onTap,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white, // Background color for the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with error handling
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              color: Colors.grey[300], // Placeholder background color
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey[700], size: 50), // Placeholder icon
                            );
                          },
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.grey[300], // Placeholder background color
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey[700], size: 50), // Placeholder icon
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title of the article
                      Text(
                        article.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent, // Text color for title
                        ),
                      ),
                      SizedBox(height: 5),
                      // Author and Source
                      Text(
                        article.source?.name ?? 'Unknown source',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 5),
                      Text(
                        article.description ?? 'No description available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}