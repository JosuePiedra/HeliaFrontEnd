import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/home/home_controller.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:helia_frontend/app/themes/responsive.dart';
import 'package:helia_frontend/widgets/notifications.dart';

class ReminderBox extends GetView<HomeController> {
  final String timeReminder;
  final String nameMedicine;
  final String specification;
  final bool active;
  final int index;

  ReminderBox({
    super.key,
    required this.active,
    required this.timeReminder,
    required this.nameMedicine,
    required this.specification,
    required this.index,
  });

  final Responsive responsive = Responsive();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(
          controller.reminders[index].id), // Llave única para cada recordatorio
      direction:
          DismissDirection.endToStart, // Solo deslizar hacia la izquierda
      onDismissed: (direction) {
        controller.apiRepository.deleteReminder(controller.reminders[index].id);
        controller.reminders.removeAt(index);
        controller.status.value.removeAt(index);
        controller.status.refresh();

        CustomToast.showSuccessToast("Se ha eliminado el recordatorio");
      },
      background: Container(
        color: Colors.red, // Fondo rojo para la acción de eliminar
        alignment: Alignment.centerRight, // Mostrarlo a la derecha
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
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
                child: Image.asset('assets/img/pill-icon.png'),
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
                      timeReminder,
                      style: TextStyle(
                        color: AppPalette.black.base,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.body.large,
                      ),
                    ),
                    customXMargin(responsive.wp(4)),
                    Text(
                      nameMedicine,
                      style: TextStyle(
                        color: AppPalette.black.base,
                        fontSize: FontSize.body.medium,
                      ),
                    ),
                  ],
                ),
                Text(
                  specification,
                  style: TextStyle(
                    color: AppPalette.black.base,
                    fontSize: FontSize.body.small,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Checkbox para completar
            Obx(() => Checkbox(
                  value: controller.status.value[index],
                  onChanged: (value) {
                    controller.status.value[index] = value!;
                    controller.status.refresh();
                    controller.apiRepository
                        .updateCompleteReminder(controller.reminders[index].id);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
