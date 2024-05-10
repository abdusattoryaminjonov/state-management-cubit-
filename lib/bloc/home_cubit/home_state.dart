
import 'package:crutcubit13/models/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{}

class HomeInitialState extends HomeState{
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState{
  @override
  List<Object?> get props => [];
}
class HomeErrorState extends HomeState{
  final String errorMessage;

  HomeErrorState(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class HomeLoadPostState extends HomeState{
  final List<Post> post;

  HomeLoadPostState(this.post);

  @override
  List<Object> get props => [post];
}

class HomeDeletePostState extends HomeState{
  late final Post post;

  @override
  List<Object> get props => [post];
}
