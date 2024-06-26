import 'package:crutcubit13/bloc/create_cubit/create_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_cubit/create_state.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late CreateCubit createCubit;

  backToFinish(){
    Navigator.of(context).pop(true);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createCubit = BlocProvider.of<CreateCubit>(context);

    createCubit.stream.listen(
          (state) {
        if (state is CreatePostState) {
          backToFinish();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Create Post"),
      ),
      body: BlocBuilder<CreateCubit, CreateState>(
        builder: (BuildContext context, CreateState state) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: createCubit.titleController,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: createCubit.bodyController,
                    decoration: const InputDecoration(hintText: "Body"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      createCubit.onCreatePost();
                    },
                    child: const Text("Creat"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}