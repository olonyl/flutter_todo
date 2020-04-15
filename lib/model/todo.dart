class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Todo(this._title, this._priority, this._date, [this._description]);
  Todo.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String newValue) {
    if (newValue.length <= 255) _title = newValue;
  }

  set description(String newValue) {
    if (newValue.length <= 255) _description = newValue;
  }

  set priority(int newValue) {
    if (newValue >= 0 && newValue <= 3) _priority = newValue;
  }

  set date(String newValue) => _date = newValue;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    if (_id != null) map["id"] = _id;
    return map;
  }

  Todo.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._priority = o["priority"];
    this._date = o["date"];
  }
}
