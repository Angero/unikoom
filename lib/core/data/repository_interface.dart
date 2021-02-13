import 'package:unikoom/core/data/data_entity.dart';

abstract class RepositoryInterface<S> {
  Future<List<S>> getList(String value);
}