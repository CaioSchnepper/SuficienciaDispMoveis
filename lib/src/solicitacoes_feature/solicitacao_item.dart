class Solicitacao {
  final int id;
  final String title;
  final String description;
  final String photo;
  final String user;
  final double latitude;
  final double longitude;
  final DateTime date;

  Solicitacao(this.id, this.title, this.description, this.photo, this.user,
      this.latitude, this.longitude, this.date);
}