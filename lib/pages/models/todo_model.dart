class TodoModel {
  int? id;
  String? text;
  bool? isDone;
  int status = 1;

  TodoModel({this.id, this.text, this.isDone});
  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isDone = json['isDone'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone,
      'status': status,
    };
  }
}

List<TodoModel> todos = [];
