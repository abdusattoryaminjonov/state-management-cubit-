import 'package:crutcubit13/bloc/update_cubit/update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/update_cubit/update_state.dart';
import '../models/post_model.dart';
import '../services/log_service.dart';

class UpdatePage extends StatefulWidget {
  final Post post;
  const UpdatePage({super.key,required this.post});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late UpdateCubit updateCubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateCubit = BlocProvider.of(context);

    updateCubit.titleController.text = widget.post.title!;
    updateCubit.bodyController.text = widget.post.body!;

    updateCubit.stream.listen((state) {
      if (state is UpdatePostState) {
        LogService.d('UpdatePostState is done');
        updateCubit.backToFinish(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Update Post"),
      ),
      body:  BlocBuilder<UpdateCubit, UpdateState>(
        builder: (BuildContext context, UpdateState state){
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: updateCubit.titleController,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: updateCubit.bodyController,
                    decoration: InputDecoration(hintText: "Body"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      updateCubit.onUpdatePost(widget.post);
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }

}