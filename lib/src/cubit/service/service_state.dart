part of 'service_cubit.dart';

@immutable
abstract class ServiceState {
  const ServiceState();
}

class ServiceInitial extends ServiceState {
  const ServiceInitial();
}

class ServiceLoading extends ServiceState {
  const ServiceLoading();
}

class ServiceLoaded extends ServiceState {
  final List<Service> listService;
  const ServiceLoaded({this.listService});
}

class ServiceError extends ServiceState {
  final String message;
  const ServiceError({this.message});
}
