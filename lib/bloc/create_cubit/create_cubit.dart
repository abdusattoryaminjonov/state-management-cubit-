import 'package:bloc/bloc.dart';
import 'package:crutcubit13/bloc/create_cubit/create_state.dart';
import 'package:flutter/cupertino.dart';

import '../../models/post_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class CreateCubit extends Cubit<CreateState>{
  CreateCubit() : super(CreateInitialState());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();



  Future<void> onCreatePost() async{

    emit(CreateLoadingState());
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    if(response != null){
      LogService.d(response);
      emit(CreatePostState(post));
    }else{
      emit(CreateErrorState("Could not create post"));
    }

  }
}