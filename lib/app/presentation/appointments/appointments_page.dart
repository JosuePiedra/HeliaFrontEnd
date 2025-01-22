import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/appointments/appointments_controller.dart';
import 'package:helia_frontend/app/presentation/appointments/widgets/chat_appointments.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';

class AppointmentsPage extends GetView<AppointmentController> {
  AppointmentsPage({super.key});
  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.getInformation.isTrue
          ? Scaffold(
              backgroundColor: Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: AppPalette.primary.base,
                iconTheme: IconThemeData(color: Colors.white),
                title: const Text(
                  'Cita médica',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(6), vertical: responsive.hp(3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(responsive.ip(1)),
                              decoration: BoxDecoration(
                                  color: AppPalette.primary.dark,
                                  shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/img/medico.png',
                                height: responsive.hp(5),
                              ),
                            ),
                            customXMargin(responsive.wp(4)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.appointment.value != null
                                      ? 'Dr. ${controller.appointment.value!.medico.nombre}'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.title.medium),
                                ),
                                Text(
                                  controller.appointment.value != null
                                      ? controller.appointment.value!.medico
                                          .especialidad
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.title.small),
                                ),
                              ],
                            ),
                          ],
                        )),
                    customYMargin(responsive.hp(2)),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: responsive.wp(4),
                              vertical: responsive.hp(2)),
                          alignment: Alignment.center,
                          width: responsive.wp(100),
                          decoration: BoxDecoration(
                            color: AppPalette.tertiary.light,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(responsive.ip(1)),
                                topRight: Radius.circular(responsive.ip(1))),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Fecha: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.body.medium,
                                    ),
                                  ),
                                  Text(
                                    controller.formatDate(controller
                                        .appointment.value!.fecha
                                        .toString()),
                                    style: TextStyle(
                                      fontSize: FontSize.body.medium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Estado: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    controller.appointment.value != null
                                        ? controller.appointment.value!.estado
                                        : '',
                                    style: TextStyle(
                                      fontSize: FontSize.body.medium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: responsive.wp(100),
                          height: responsive.hp(1),
                          decoration: BoxDecoration(
                            color: controller.appointment.value != null
                                ? controller.appointment.value!.estado ==
                                        'finalizado'
                                    ? Colors.green
                                    : Colors.orange
                                : Colors.black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(responsive.ip(1)),
                                bottomRight: Radius.circular(responsive.ip(1))),
                          ),
                        )
                      ],
                    ),
                    Container(),
                    const SizedBox(height: 16),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Medicamentos',
                          style: Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Aqui podrás colocar los exámenes que debes realizarte',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Exámenes',
                          style: Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Aqui podrás colocar los exámenes que debes realizarte',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        )),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Comentarios',
                          style: Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          textAlign: TextAlign.center,
                          'Aqui podrás encontrar información extra que tú médico podrá mencionar despues de la consulta',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        )),
                    customYMargin(responsive.hp(2)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: AppPalette.primary.base,
                onPressed: (() => Get.to(ChatAppointments())),
                label: const Text(
                  '¿Tienes alguna consulta?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Color(0xffFFFFFF),
              appBar: AppBar(
                backgroundColor: AppPalette.primary.base,
                iconTheme: IconThemeData(color: Colors.white),
                title: const Text(
                  'Cita médica',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
