class Articles {
  String? author;
  String? title;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Source? source;

  Articles({
    this.author,
    this.title,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      source:
          json['source'] != null ? Source.fromJson(json['source']) : null,
    );
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
