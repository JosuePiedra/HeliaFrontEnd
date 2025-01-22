import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/data/models/reminder_conult_model.dart';
import 'package:helia_frontend/app/presentation/home/home_controller.dart';
import 'package:helia_frontend/app/routes/app_pages.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';
import 'package:helia_frontend/widgets/notifications.dart';
import 'package:intl/intl.dart';

class ConsultBox extends GetView<HomeController> {
  final String speciality;
  final String nameDoctor;
  final String idAppointment;
  final String fecha;
  final bool active;
  final int index;

  ConsultBox({
    super.key,
    required this.active,
    required this.speciality,
    required this.nameDoctor,
    required this.idAppointment,
    required this.fecha,
    required this.index,
  });

  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(fecha.toString());

    // Formatear la fecha

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.appointments,
            parameters: {'appointmentId': idAppointment});
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppPalette.tertiary.light,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(1), vertical: responsive.hp(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Ícono de medicina
            Container(
              decoration: BoxDecoration(
                color: AppPalette.white.base,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(responsive.ip(1)),
              child: SizedBox(
                height: responsive.hp(4),
                width: responsive.wp(10),
                child: Image.asset('assets/img/medic-calendar.png'),
              ),
            ),
            customXMargin(responsive.wp(2)),
            // Detalles del recordatorio
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Dr. ${nameDoctor}',
                      style: TextStyle(
                        color: AppPalette.black.base,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.body.large,
                      ),
                    ),
                    customXMargin(responsive.wp(4)),
                  ],
                ),
                Text(
                  speciality,
                  style: TextStyle(
                    color: AppPalette.black.base,
                    fontSize: FontSize.body.medium,
                  ),
                ),
                Text(
                  DateFormat("d 'de' MMMM 'a las' HH:mm", "es_ES")
                      .format(parsedDate),
                  style: TextStyle(
                    color: AppPalette.black.base,
                    fontSize: FontSize.body.small,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Checkbox para completar
          ],
        ),
      ),
    );
  }
}
