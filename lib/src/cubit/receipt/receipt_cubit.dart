import 'package:bloc/bloc.dart';
import 'package:hotel_management/src/data/model/recreipt_model.dart';
import 'package:meta/meta.dart';

part 'receipt_state.dart';

class RecreiptCubit extends Cubit<ReceiptState> {
  RecreiptCubit() : super(ReceiptInitial());
}
