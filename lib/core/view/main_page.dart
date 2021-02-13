import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unikoom/core/bloc/take_bloc.dart';
import 'package:unikoom/core/data/data_entity.dart';
import 'package:unikoom/core/data/mock_repository.dart';
import 'package:unikoom/core/view/detail_page.dart';
import 'package:unikoom/core/view/message_container.dart';
import 'package:unikoom/core/view/waiting_container.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TakeBloc _takeBloc;

  @override
  void initState() {
    super.initState();
    _takeBloc = TakeBloc(repository: MockRepository())..add(SendTakeEvent(''));
  }

  @override
  void dispose() {
    _takeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: SafeArea(
        child: _mainWidget(),
      ),
    );
  }

  Widget _mainWidget() {
    return Column(
      children: [
        _findWidget(),
        Expanded(child: _blocBuilder()),
      ],
    );
  }

  Widget _findWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          _takeBloc.add(SendTakeEvent(value));
        },
      ),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<TakeBloc, TakeState>(
      cubit: _takeBloc,
      builder: (BuildContext context, TakeState takeState) {
        if (takeState is SuccessTakeState) {
          return _listWidget(takeState.success);
        } else if (takeState is FailureTakeState) {
          return MessageContainer(message: takeState.error);
        } else if (takeState is WaitingTakeState) {
          return WaitingContainer();
        }
        return MessageContainer(message: 'Unknown');
      },
    );
  }

  Widget _listWidget(List<DataEntity> list) {
    return list.length == 0
        ? Center(child: Text('No data'))
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Text(list.elementAt(index).title),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          list.elementAt(index).comment,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16.0),
                        RaisedButton(
                          child: Text('More...'),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(
                                    title: list.elementAt(index).title,
                                    comment: list.elementAt(index).comment,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
  }
}
