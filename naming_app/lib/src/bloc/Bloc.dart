import 'dart:async';

class Bloc {
  Set<String> saved = Set<String>();

  final _savedController = StreamController<Set<String>>();

  get savedListStream => _savedController.stream;

  addToOrRemoveFromSavedList(String item) {
    if (saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }
    _savedController.sink.add(saved); // sink는 파이프 입구
  }

//  Stream<Set<String>> savedListStream() {
//    return _savedController.stream;
//  }

  dispose() {
    _savedController.close();
  }
}

final bloc = Bloc();
