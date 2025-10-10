import 'package:driveresq/model/request_model.dart';
import 'package:driveresq/services/request_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RequestController extends GetxController {
  final _RequestService = Request();
  final _UserRequest = <RequestSOS>[].obs;
  final _MechanicRequest = <RequestSOS>[].obs;

  void fetchUserRequest(String userId) {
    _RequestService.getRequestforUser(userId).listen((Request) {
      _UserRequest.value = Request;
    });
  }

  void fetchMechanicRequest(String mechanicId) {
    _RequestService.getRequestforMechanic(mechanicId).listen((Request) {
      _MechanicRequest.value = Request;
    });
  }

  Future<void> CreateSoSRequest(RequestSOS SosRequest) async {
    await _RequestService.createSOSRequest(SosRequest);
  }
}
