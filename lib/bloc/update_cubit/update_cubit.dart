import 'package:bloc/bloc.dart';
import 'package:crutcubit13/bloc/update_cubit/update_state.dart';
import 'package:flutter/cupertino.dart';

import '../../models/post_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class UpdateCubit extends Cubit<UpdateState>{
  UpdateCubit() : super(UpdateInitialState());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  backToFinish(BuildContext context){
    Navigator.of(context).pop(true);
  }

  Future<void> onUpdatePost(Post post) async{
    emit(UpdateLoadingState());

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post newPost = post;
    newPost.title = title;
    newPost.body = body;

    var response = await Network.PUT(Network.API_POST_UPDATE + newPost.id.toString(), Network.paramsUpdate(newPost));
    if(response != null){
      LogService.d(response);
      emit(UpdatePostState(post));
    }else{
      emit(UpdateErrorState("Post has not been edited!"));
    }

  }


}
