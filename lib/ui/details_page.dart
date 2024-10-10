import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';
import '../providers/menu_data_provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userDataProvider = Provider.of<menuDataProvider>(context);
    Articles articles = userDataProvider.Details!;

    // Formatting the published date
    String formattedDate = DateFormat('MMMM dd, yyyy').format(
      DateTime.parse(articles.publishedAt!),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'News Article',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Center(
                child: Text(
                  articles.title ?? '',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),

              // Image with rounded corners and error handling
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: articles.urlToImage != null
                      ? Image.network(
                          articles.urlToImage!,
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.broken_image, color: Colors.grey[700], size: 50),
                              ),
                            );
                          },
                        )
                      : Placeholder(
                          fallbackHeight: MediaQuery.of(context).size.height * 0.25,
                          fallbackWidth: double.infinity,
                        ),
                ),
              ),
              SizedBox(height: 15),

              // Author and Published Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Author: ${articles.author ?? 'Unknown'}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Description Section
              Text(
                "Description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  articles.description ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 20),

              // Content Section
              Text(
                "Content:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  articles.content ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 20),

              // Action buttons (e.g., Share button)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for reading the article in a web view or browser
                    },
                    icon: Icon(Icons.open_in_browser),
                    label: Text('Read More'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for sharing the article
                    },
                    icon: Icon(Icons.share),
                    label: Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
