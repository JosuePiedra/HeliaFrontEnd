import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/home/home_controller.dart';
import 'package:helia_frontend/app/presentation/home/widgets/consult.dart';
import 'package:helia_frontend/app/presentation/home/widgets/reminder.dart';
import 'package:helia_frontend/app/routes/app_pages.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';

class HomePage extends GetView<HomeController> {
  final Responsive responsive = Responsive();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: AppPalette.primary.base,
              width: responsive.width,
              padding: EdgeInsets.only(
                top: responsive.hp(8),
                bottom: responsive.hp(3),
                right: responsive.hp(5),
                left: responsive.wp(10),
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, Agustin Churo',
                        style: TextStyle(
                          color: AppPalette.white.base,
                          fontSize: FontSize.title.medium,
                        ),
                      ),
                      Text(
                        '¿En qué puedo ayudarte hoy?',
                        style: TextStyle(
                          color: AppPalette.white.base,
                          fontSize: FontSize.title.large,
                        ),
                      ),
                    ],
                  ),
                  customYMargin(responsive.hp(2)),
                  GestureDetector(
                    onTap: () async => {
                      await Get.toNamed(Routes.chatBot),
                      controller.getReminder()
                    },
                    child: Hero(
                      tag: 'search',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: responsive.hp(4.5),
                            padding: EdgeInsets.only(
                                left: responsive.wp(5),
                                right: responsive.wp(5)),
                            decoration: BoxDecoration(
                                color: Color(0xff799BE5),
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(responsive.ip(0.5)),
                                    bottomLeft:
                                        Radius.circular(responsive.ip(0.5)))),
                            child: Text('Analiza los siguientes resultados',
                                style: Get.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                          Container(
                            height: responsive.hp(4.5),
                            width: responsive.wp(9),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(responsive.ip(0.5)),
                                    bottomRight:
                                        Radius.circular(responsive.ip(0.5)))),
                            child: Icon(
                              Icons.search,
                              color: Get.theme.colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xffFFFFFF),
              child: Padding(
                padding: EdgeInsets.only(
                  top: responsive.hp(2),
                  bottom: responsive.hp(2),
                  right: responsive.hp(5),
                  left: responsive.wp(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recordatorios',
                          style: Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Obx(() => ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ReminderBox(
                                  nameMedicine:
                                      controller.reminders[index].title,
                                  specification:
                                      controller.reminders[index].description,
                                  timeReminder:
                                      controller.reminders[index].reminderTime,
                                  active: controller.reminders[index].status,
                                  index: index,
                                ),
                                customYMargin(responsive.hp(2)),
                              ],
                            );
                          },
                          itemCount: controller.reminders.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Citas médicas',
                          style: Get.textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Próximas',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    controller.futureConsults.length != 0
                        ? Obx(() => ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ConsultBox(
                                      nameDoctor: controller
                                          .futureConsults[index].medico,
                                      idAppointment: controller
                                          .previousConsults[index].id,
                                      speciality: controller
                                          .futureConsults[index]
                                          .doctorSpeciality,
                                      index: index,
                                      active: false,
                                      fecha: controller
                                          .futureConsults[index].fecha
                                          .toString(),
                                    ),
                                    customYMargin(responsive.hp(2)),
                                  ],
                                );
                              },
                              itemCount: controller.futureConsults.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ))
                        : ElevatedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                      vertical: responsive.hp(1.5),
                                      horizontal: responsive.wp(5))),
                              backgroundColor: WidgetStateProperty.all(
                                  AppPalette.primary.base),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add, color: Colors.white),
                                customXMargin(responsive.wp(3)),
                                Text(
                                  'Agenda una cita médica ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.body.medium),
                                ),
                              ],
                            ),
                          ),
                    customYMargin(responsive.hp(2)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Anteriores',
                          style: Get.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                    customYMargin(responsive.hp(2)),
                    Obx(() => Column(
                          children: [
                            // Lista con animación
                            AnimatedSize(
                              duration: const Duration(
                                  milliseconds:
                                      300), // Duración de la animación
                              curve:
                                  Curves.easeInOut, // Suavizado de la animación
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ConsultBox(
                                        nameDoctor: controller
                                            .previousConsults[index].medico,
                                        idAppointment: controller
                                            .previousConsults[index].id,
                                        speciality: controller
                                            .previousConsults[index]
                                            .doctorSpeciality,
                                        index: index,
                                        active: false,
                                        fecha: controller
                                            .previousConsults[index].fecha
                                            .toString(),
                                      ),
                                      customYMargin(responsive.hp(2)),
                                    ],
                                  );
                                },
                                itemCount: controller.previousConsults.length >
                                        3
                                    ? controller.showMoreAppointments.isFalse
                                        ? 3
                                        : controller.previousConsults.length
                                    : controller.previousConsults.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ),
                            // Botón para expandir/contraer
                            controller.previousConsults.length > 3
                                ? ElevatedButton(
                                    onPressed: () => {
                                      controller.showMoreAppointments.value =
                                          !controller.showMoreAppointments.value
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: responsive.wp(5))),
                                      backgroundColor: WidgetStateProperty.all(
                                          AppPalette.primary.base),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    child: Icon(
                                      controller.showMoreAppointments.isFalse
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_drop_up,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            customYMargin(responsive.hp(2)),
          ],
        ),
      ),
    );
  }
}
