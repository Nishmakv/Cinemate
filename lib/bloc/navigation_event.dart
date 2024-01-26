part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationProcess extends NavigationEvent {
  final int index;
  
  const NavigationProcess({required this.index});
}
