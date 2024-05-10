import 'package:crutcubit13/bloc/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/home_cubit/home_state.dart';
import '../models/post_model.dart';
import '../views/item_of_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late HomeCubit homeCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.onLoadPost();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("CUBIT"),
      ),
      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (BuildContext context , HomeState state){
          if(state is HomeErrorState){
            return viewOfError(state.errorMessage);
          }
          if(state is HomeLoadPostState){
            var postList = state.post;
            return viewOfPostList(postList);
          }
          return viewOfLoading();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          homeCubit.onCreatePost(context);
        },
      ),
    );
  }

  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget viewOfPostList(List<Post> post){
    return ListView.builder(
      itemCount: post.length,
      itemBuilder: (ctx,index){
        return itemOfPost(post[index],index,homeCubit);
      },
    );
  }



}