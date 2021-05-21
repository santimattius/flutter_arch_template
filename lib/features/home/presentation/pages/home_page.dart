import 'dart:io';

import 'package:flutter/cupertino.dart' as IOS;
import 'package:flutter/material.dart' as Android;
import 'package:flutter/widgets.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_bloc.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_event.dart';
import 'package:flutter_arch_template/features/home/presentation/bloc/home_pictures_state.dart';
import 'package:flutter_arch_template/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_arch_template/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const _PAGE_TITLE = 'Flutter App Template';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOS.CupertinoPageScaffold(
        // Uncomment to change the background color
        navigationBar: const IOS.CupertinoNavigationBar(
          middle: Text(_PAGE_TITLE),
        ),
        child: buildBody(context),
      );
    } else {
      return Android.Scaffold(
        appBar: Android.AppBar(
          title: Text(_PAGE_TITLE),
        ),
        body: buildBody(context),
      );
    }
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => sl<HomePicturesBloc>(),
        child: BlocBuilder<HomePicturesBloc, HomeState>(
          builder: (context, state) {
            return currentStateWidget(context, state);
          },
        ),
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
          physics: scrollPhysics(),
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

  IOS.ScrollPhysics scrollPhysics() {
    return Platform.isIOS
        ? IOS.BouncingScrollPhysics()
        : Android.ClampingScrollPhysics();
  }
}
