part of 'receipt_cubit.dart';

@immutable
abstract class ReceiptState {
  const ReceiptState();
}

class ReceiptInitial extends ReceiptState {
  const ReceiptInitial();
}

class ReceiptLoading extends ReceiptState {
  const ReceiptLoading();
}

class ReceiptLoaded extends ReceiptState {
  final List<Receipt> listReceipt;
  const ReceiptLoaded({this.listReceipt});
}

class ReceiptError extends ReceiptState {
  final String message;
  const ReceiptError({this.message});
}
