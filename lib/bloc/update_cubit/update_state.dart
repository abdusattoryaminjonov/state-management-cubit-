import 'package:equatable/equatable.dart';

import '../../models/post_model.dart';

abstract class UpdateState extends Equatable{}

class UpdateInitialState extends UpdateState{
  @override
  List<Object?> get props => [];
}

class UpdateLoadingState extends UpdateState{
  @override
  List<Object?> get props => [];
}
class UpdateErrorState extends UpdateState{
  final String errorMessage;

  UpdateErrorState(this.errorMessage);

  @override
  List<Object?> get props => [];
}

class UpdatePostState extends UpdateState {
  final Post post;

  UpdatePostState(this.post);

  @override
  List<Object?> get props => [post];
}
