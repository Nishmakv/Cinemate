import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';


class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0);
  @override
  Stream<int> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationProcess) {
      yield event.index;
    }
  }
}
