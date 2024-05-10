import 'package:bloc/bloc.dart';
import 'package:crutcubit13/bloc/create_cubit/create_cubit.dart';
import 'package:crutcubit13/bloc/home_cubit/home_state.dart';
import 'package:crutcubit13/bloc/update_cubit/update_cubit.dart';
import 'package:crutcubit13/pages/create_page.dart';
import 'package:crutcubit13/pages/update_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitialState());

  List<Post> posts = [];

  Future<void> onLoadPost()async{
    emit(HomeLoadingState());
    var response = await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    if(response != null){
      var results = Network.parsePostList(response);
      posts.addAll(results);
      LogService.d(response);
      emit(HomeLoadPostState(posts));
    }else{
      emit(HomeErrorState("Postlar kelmadi. Dasturda hatolik!"));
    }
  }

  Future<void> onDeletePost(Post post)async{
    emit(HomeDeletePostState());
    var response = await Network.DEL(Network.API_POST_DELETE + post.id.toString(), Network.paramsEmpty());
    if(response != null){
      LogService.d(response);
      emit(HomeLoadPostState  (posts));
    }else{
      emit(HomeErrorState("Postlar kelmadi. Dasturda hatolik!"));
    }
  }

  Future<void> onCreatePost(BuildContext context)async{
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return BlocProvider(
            create: (context) => CreateCubit(),
            child: CreatePage(),
          );
        }
      )
    );

    if (result) {
      onLoadPost();
    }
  }
  Future<void> onUpdatePost(BuildContext context, Post post)async{
    bool result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context){
              return BlocProvider(
                create: (context) => UpdateCubit(),
                child: UpdatePage(post: post,),
              );
            }
        )
    );
    if (result) {
      onLoadPost();
    }
  }

}