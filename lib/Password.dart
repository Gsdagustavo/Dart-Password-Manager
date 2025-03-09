class Password {

  // attributes
  String? _password;
  int? _id;
  List<String>? _tags;

  // constructor
  Password(this._password, this._id);

  // getters and setters
  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags!;

  // function that adds a tag to the tags list
  void addTag(String tag) {

    if (tag.isNotEmpty) {
      if (!tags.contains(tag)) {
        tags.add(tag);
      } else {
        print('tag $tag already exists on the list');
      }
    } else {
      print('invalid tag');
    }
  }
}