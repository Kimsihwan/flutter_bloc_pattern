import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';
import 'package:restaurant_finder/bloc/Bloc.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    //  1의 BLOC 입력에서 이 메소드는 문자열을 허용하고 시작 프로젝트의 ZomatoClient 클래스를 사용하여 API에서 위치를 가져옵니다.
    // Dart의 async / await 구문을 사용하여 코드를 좀 더 깔끕하게 만듭니다. 그런 다음 결과가 스트림에 게시 됩니다.
    // BLOC은 위치를 저장하고 보고하는 대신 API 호출을 캡슣롸한다는 점을 제외하면 마지막 BLOC와 거의 동일합니다
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
