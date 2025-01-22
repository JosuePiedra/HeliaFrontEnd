import 'package:helia_frontend/app/data/models/api_response_model.dart';

abstract class ApiRepository {
  Future<ApiResponseModel> getResponse(prompt, chatId);
  Future<ApiResponseModel> getReminders(userId);
  Future<ApiResponseModel> updateCompleteReminder(reminderId);
  Future<ApiResponseModel> deleteReminder(reminderId);
  Future<ApiResponseModel> getConsult(userId);
  Future<ApiResponseModel> getAppointment(appointmentId);
  Future<ApiResponseModel> appointmentChat(prompt, chatId, appointmentId);
}
