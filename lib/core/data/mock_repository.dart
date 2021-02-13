import 'package:faker/faker.dart';
import 'package:unikoom/core/data/data_entity.dart';
import 'package:unikoom/core/data/repository_interface.dart';

class MockRepository implements RepositoryInterface<DataEntity> {
  MockRepository() {
    _list = List();
    for (int i = 0; i < 20; i++) {
      DataEntity dataEntity = DataEntity(
          faker.lorem.sentence(), faker.lorem.sentences(10).join(' '));
      _list.add(dataEntity);
    }
  }

  List<DataEntity> _list;

  @override
  Future<List<DataEntity>> getList(String value) async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      if (value.isEmpty) return _list;
      List<DataEntity> result = List();
      for (DataEntity entity in _list)
        if (entity.title.contains(value)) result.add(entity);
      return result;
    } catch (e, stacktrace) {
      print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
      return null;
    }
  }
}
