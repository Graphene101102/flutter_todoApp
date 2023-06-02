class TodoModel {
  int? id;
  String? text;
  int? status;

  TodoModel({this.id, this.text, this.status});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'status': status};
  }
}

List<TodoModel> todos = [];
