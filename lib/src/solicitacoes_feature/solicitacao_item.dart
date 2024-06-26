class Solicitacao {
  String id;
  String title;
  String description;
  String photo;
  String user;
  double latitude;
  double longitude;
  DateTime date;
  List<String> comments;

  Solicitacao(this.id, this.title, this.description, this.photo, this.user,
      this.latitude, this.longitude, this.date, this.comments);

  Solicitacao.fromJson(Map<String, dynamic> json, String key)
      : id = key,
        title = json['title'],
        description = json['description'],
        photo = json['photo'],
        user = json['user'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        date = DateTime.parse(json['date']),
        comments = toCommentsList(
            json['comments'] ?? List<String>.empty(growable: true));

  static List<String> toCommentsList(List<dynamic> list) {
    return list.map((comment) => comment.toString()).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'photo': photo,
        'user': user,
        'latitude': latitude,
        'longitude': longitude,
        'date': date.toString(),
        'comments': comments
      };
}
