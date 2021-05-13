import 'package:bloc/bloc.dart';
import 'package:hotel_management/src/data/model/service_model.dart';
import 'package:hotel_management/src/data/responsitory/service_repository.dart';
import 'package:meta/meta.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceRepository _serviceRepository;
  ServiceCubit(this._serviceRepository) : super(ServiceInitial());

  Future<void> getListService() async {
    try {
      emit(ServiceLoading());
      final listService = await _serviceRepository.fetchListService();
      emit(ServiceLoaded(listService: listService));
    } catch (e) {
      emit(ServiceError(message: e.toString()));
    }
  }
}
