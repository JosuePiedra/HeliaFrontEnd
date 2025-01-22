import 'package:helia_frontend/app/data/models/api_response_model.dart';
import 'package:helia_frontend/app/data/repositories/api_repository.dart';
import 'package:helia_frontend/app/utils/helpers/network_helper.dart';

class ApiProvider extends ApiRepository {
  final NetworkUtil _netUtil = NetworkUtil();
  @override
  Future<ApiResponseModel> getResponse(prompt, chatId) {
    return _netUtil.post(path: 'api/v1/chatbot/intentions', body: {
      "userId": "67773072b13a56e7e498ec93",
      "chatId": chatId,
      "prompt": prompt
    }).then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> getReminders(userId) {
    return _netUtil
        .get(path: 'api/v1/reminder/$userId')
        .then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> getConsult(userId) {
    return _netUtil
        .get(path: 'api/v1/consult/getConsultFull/$userId')
        .then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> updateCompleteReminder(reminderId) {
    return _netUtil
        .get(path: 'api/v1/reminder/complete/$reminderId')
        .then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> deleteReminder(reminderId) {
    return _netUtil
        .get(path: 'api/v1/reminder/delete/$reminderId')
        .then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> getAppointment(appointmentId) {
    return _netUtil
        .get(path: 'api/v1/consult/$appointmentId')
        .then((value) => ApiResponseModel.fromJson(value));
  }

  @override
  Future<ApiResponseModel> appointmentChat(prompt, chatId, appointmentId) {
    return _netUtil.post(path: 'api/v1/chatbot/appointmentChat', body: {
      "userId": "67773072b13a56e7e498ec93",
      "chatId": chatId,
      "prompt": prompt,
      "contextAppointent": appointmentId
    }).then((value) => ApiResponseModel.fromJson(value));
  }
}
