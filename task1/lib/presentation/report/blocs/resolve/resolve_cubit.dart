import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/data/models/resolve/resolve_req.dart';
import 'package:task1/domain/usecase/resolve.dart';
import 'package:task1/presentation/report/blocs/resolve/resolve_state.dart';
import 'package:task1/service_locator.dart';

class ResolveCubit extends Cubit<ResolveState> {
  ResolveCubit() : super(ResolveInitialState());

  Future<void> resolve(ResolveReq resolveReq) async {
    try {
      emit(ResolveLoading());

      var returnedData = await sl<ResolveUsecase>().call(params: resolveReq);
      returnedData.fold((error) {
        emit(ResolveFailure(errorMess: error));
      }, (data) {
        emit(ResolveLoaded(totalPrice: data));
      });
    } catch (e) {
      emit(ResolveFailure(errorMess: "Something went wrong"));
    }
  }
}
