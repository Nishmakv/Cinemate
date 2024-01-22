import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());
  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationProcess) {
      yield NavigationSuccess(event.index);
    }
  }
 
}
