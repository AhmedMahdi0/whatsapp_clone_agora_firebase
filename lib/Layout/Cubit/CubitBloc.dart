

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'StateBloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);
}
