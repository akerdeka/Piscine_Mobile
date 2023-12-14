class DataModel {

  String docId = "";

  DateTime date = DateTime(2023);
  String? userEmail = "";
  String feeling = "";
  String title = "";
  String content = "";

  DataModel(this.date, this.userEmail, this.title, this.content, this.feeling, this.docId);
}