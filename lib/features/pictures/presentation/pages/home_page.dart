import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch_template/features/pictures/presentation/bloc/home_pictures_bloc.dart';
import 'package:flutter_arch_template/features/pictures/presentation/bloc/home_pictures_event.dart';
import 'package:flutter_arch_template/features/pictures/presentation/bloc/home_pictures_state.dart';
import 'package:flutter_arch_template/features/pictures/presentation/widgets/widgets.dart';
import 'package:flutter_arch_template/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App Template'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: buildBody(context),
        ),
      ),
    );
  }

  BlocProvider<HomePicturesBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomePicturesBloc>(),
      child: BlocBuilder<HomePicturesBloc, HomeState>(
        builder: (context, state) {
          return currentStateWidget(context, state);
        },
      ),
    );
  }

  Widget currentStateWidget(BuildContext context, HomeState state) {
    if (state is Init) {
      BlocProvider.of<HomePicturesBloc>(context).add(GetPicturesEvent());
      return Container();
    } else if (state is Empty) {
      return MessageDisplay(
        message: 'No result available!',
      );
    } else if (state is Loading) {
      return LoadingWidget();
    } else if (state is Loaded) {
      final pictures = state.pictures;
      return ListView.builder(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: pictures.length,
          itemBuilder: (BuildContext context, int index) {
            return PictureCard(pictures[index]);
          });
    } else if (state is Error) {
      return MessageDisplay(
        message: state.message,
      );
    } else {
      return Container();
    }
  }
}
