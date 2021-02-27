class Note {

  var _id;
  var _title;
  var _description;
  var _date;
  var _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;
    return map;
  }
  
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }

  get priority => _priority;

  get date => _date;

  get description => _description;

  get title => _title;

  get id => _id;

  set priority(value) {
    _priority = value;
  }

  set date(value) {
    _date = value;
  }

  set description(value) {
    _description = value;
  }

  set title(value) {
    _title = value;
  }
}