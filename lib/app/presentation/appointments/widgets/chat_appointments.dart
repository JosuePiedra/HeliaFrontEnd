import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:helia_frontend/app/presentation/appointments/appointments_controller.dart';
import 'package:helia_frontend/app/presentation/chatBot/chatBot_controller.dart';
import 'package:helia_frontend/app/presentation/chatBot/widgets/buttons_function.dart';
import 'package:helia_frontend/app/presentation/chatBot/widgets/consult_medic.dart';
import 'package:helia_frontend/app/presentation/chatBot/widgets/medic_container.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';
import 'package:helia_frontend/app/themes/custom_margin.dart';
import 'package:helia_frontend/app/themes/font_size.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:helia_frontend/app/themes/responsive.dart';
import 'package:intl/intl.dart';

class ChatAppointments extends GetView<AppointmentController> {
  final Responsive responsive = Responsive();
  ChatAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: AppBar(
          title: SizedBox(
            height: responsive.hp(4),
            width: responsive.wp(30),
            child: Image.asset('assets/img/Logo.png'),
          ),
        ),
        body: SingleChildScrollView(
          // Agregado aquí
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: responsive.hp(85),
            width: responsive.width,
            child: Obx(() => Chat(
                  emptyState: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customYMargin(responsive.hp(5)),
                        SizedBox(
                          width: responsive.wp(70),
                          child: Text(
                            textAlign: TextAlign.center,
                            '¿Tienes alguna duda con respecto a tú consulta?',
                            style: TextStyle(
                              fontSize: FontSize.headline.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        customYMargin(responsive.hp(5)),
                        // SizedBox(
                        //   width: responsive.wp(70),
                        //   child: Text(
                        //     textAlign: TextAlign.center,
                        //     'Estoy aquí 24/7 para ayudarte a gestionar tu salud. Desde resolver dudas médicas hasta recordarte tomar tus medicamentos, ¡cuenta conmigo para hacer tu experiencia más simple y segura!',
                        //     style: TextStyle(
                        //       fontSize: FontSize.body.large,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        // ),
                        // customYMargin(responsive.hp(5)),
                        // ButtonsFunction()
                      ]),
                  theme: DefaultChatTheme(
                    primaryColor: AppPalette.primary.base,
                    inputBackgroundColor: Colors.white,
                    inputTextColor: Colors.black,
                    inputBorderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                    inputPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    inputMargin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    sendButtonIcon: const Icon(Icons.send, color: Colors.white),
                  ),
                  bubbleBuilder: (child,
                      {required types.Message message,
                      required bool nextMessageInGroup}) {
                    // Si el mensaje es del bot
                    if (message.author.id == 'bot') {
                      return Container(
                        alignment: Alignment
                            .centerLeft, // Alinea el texto a la izquierda

                        child: child,
                      );
                    }

                    // Si el mensaje es del usuario
                    return Container(
                      decoration: BoxDecoration(
                        color: AppPalette.primary
                            .base, // Fondo azul para mensajes del usuario
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(responsive.ip(1.5)),
                            topRight: Radius.circular(responsive.ip(1.5)),
                            bottomLeft: Radius.circular(responsive.ip(1.5))),
                      ),
                      child: child,
                    );
                  },
                  customBottomWidget: Container(
                    margin: EdgeInsets.all(responsive.ip(1)),
                    decoration: BoxDecoration(
                      color: AppPalette.tertiary.light,
                      borderRadius: BorderRadius.circular(responsive.ip(2)),
                    ),
                    child: Hero(
                      tag: 'search',
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(responsive.ip(0.5)),
                            child: Container(
                              height: responsive.hp(5),
                              width: responsive.hp(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.folder,
                                  color: Colors.black,
                                  size: responsive.ip(2.2),
                                ),
                                onPressed: () {
                                  final text =
                                      controller.textEditingController.text;
                                  if (text.isNotEmpty) {
                                    controller.handleSendPressed(
                                        types.PartialText(text: text));
                                    controller.textEditingController.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                          // Campo de texto con Material
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: responsive.hp(0.5),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: TextFormField(
                                  controller: controller.textEditingController,
                                  onFieldSubmitted: (value) {
                                    controller.handleSendPressed(
                                        types.PartialText(text: value));
                                    controller.textEditingController.clear();
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Escribe tu mensaje...',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  style: Get.textTheme.bodyMedium,
                                  minLines:
                                      1, // Número mínimo de líneas visibles
                                  maxLines:
                                      null, // Permite crecimiento vertical dinámico
                                  keyboardType: TextInputType
                                      .multiline, // Permite múltiples líneas
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(responsive.ip(0.6)),
                            child: Container(
                              height: responsive.hp(5),
                              width: responsive.hp(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 224, 224, 224),
                              ),
                              child: IconButton(
                                icon: Obx(
                                  () =>
                                      controller.waitingResponse.value == false
                                          ? const Icon(Icons.send,
                                              color: Colors.black)
                                          : const Icon(Icons.stop,
                                              color: Colors.black),
                                ),
                                onPressed: () {
                                  final text =
                                      controller.textEditingController.text;
                                  if (text.isNotEmpty) {
                                    controller.handleSendPressed(
                                        types.PartialText(text: text));
                                    controller.textEditingController.clear();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  customMessageBuilder: (types.CustomMessage message,
                      {required int messageWidth}) {
                    // Verifica si es el tipo de mensaje especial 1 (recordatorio)

                    if (message.metadata?['type'] == 'special 1') {
                      final reminderIndex =
                          message.metadata?['reminderIndex'] as int;
                      final reminder = controller.reminders[reminderIndex];

                      return Padding(
                        padding: EdgeInsets.only(
                          top: responsive.hp(2),
                          bottom: responsive.hp(2),
                          left: responsive.wp(3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título del mensaje
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3)),
                              child: Text(
                                '¡Perfecto! Aquí está tu recordatorio',
                                style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Contenedor del recordatorio
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: responsive.hp(2),
                                horizontal: responsive.wp(8),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(
                                        responsive.ip(0.5), responsive.ip(0.4)),
                                    blurRadius: 6,
                                    spreadRadius: 0.5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // Ícono
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppPalette.white.base,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(responsive.ip(1)),
                                    child: Container(
                                      height: responsive.hp(5),
                                      width: responsive.wp(10),
                                      child: Image.asset(
                                          'assets/img/pill-icon.png'),
                                    ),
                                  ),
                                  customXMargin(responsive.wp(2)),
                                  // Detalles del recordatorio
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            reminder.reminderTime,
                                            style: TextStyle(
                                              color: AppPalette.black.base,
                                              fontWeight: FontWeight.bold,
                                              fontSize: FontSize.body.large,
                                            ),
                                          ),
                                          customXMargin(responsive.wp(4)),
                                          Text(
                                            reminder.title,
                                            style: TextStyle(
                                              color: AppPalette.black.base,
                                              fontSize: FontSize.body.medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        reminder.description,
                                        style: TextStyle(
                                          color: AppPalette.black.base,
                                          fontSize: FontSize.body.small,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Mensaje de continuación
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3)),
                              child: Text(
                                '¿Deseas realizar otra modificación? O agregar otro recordatorio.',
                                style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (message.metadata?['type'] == 'consulta') {
                      final reminderIndex =
                          message.metadata?['consultIndex'] as int;
                      final consult = controller.consults[reminderIndex];

                      // Convertir el string de la fecha a un objeto DateTime
                      DateTime parsedDate =
                          DateTime.parse(consult.fecha.toString());

                      // Formatear la fecha
                      String formattedDate =
                          DateFormat("d 'de' MMMM 'a las' HH:mm", "es_ES")
                              .format(parsedDate);

                      return Padding(
                        padding: EdgeInsets.only(
                          top: responsive.hp(2),
                          bottom: responsive.hp(2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título del mensaje
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3)),
                              child: Text(
                                '¡Perfecto! Aquí está tu cita médica',
                                style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Contenedor del recordatorio
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: responsive.hp(2),
                                horizontal: responsive.wp(8),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(
                                        responsive.ip(0.5), responsive.ip(0.4)),
                                    blurRadius: 6,
                                    spreadRadius: 0.5,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // Ícono
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppPalette.white.base,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(responsive.ip(1)),
                                    child: Container(
                                      height: responsive.hp(5),
                                      width: responsive.wp(10),
                                      child: Image.asset(
                                          'assets/img/medic-calendar.png'),
                                    ),
                                  ),
                                  customXMargin(responsive.wp(2)),
                                  // Detalles del recordatorio
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            controller.medicName.value,
                                            style: TextStyle(
                                              color: AppPalette.black.base,
                                              fontSize: FontSize.body.medium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          color: AppPalette.black.base,
                                          fontSize: FontSize.body.small,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Mensaje de continuación
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3)),
                              child: Text(
                                '¿Deseas realizar otra modificación? O agregar otro recordatorio.',
                                style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Verifica si es el tipo de mensaje especial 2
                    if (message.metadata?['type'] == 'special 2') {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: responsive.hp(2),
                          bottom: responsive.hp(2),
                          left: responsive.wp(3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.metadata?['response'].split("~")[0],
                              style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500),
                            ),
                            customYMargin(responsive.hp(2)),
                            SizedBox(
                              width: responsive.wp(100),
                              child: ButtonsFunction(),
                            ),
                            customYMargin(responsive.hp(2)),
                            Text(
                              message.metadata?['response'].split("~")[1],
                              style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    }

                    if (message.metadata?['type'] == 'no soportada') {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: responsive.hp(2),
                          bottom: responsive.hp(2),
                          left: responsive.wp(3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.metadata?['response'].split("~")[0],
                              style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500),
                            ),
                            customYMargin(responsive.hp(2)),
                            SizedBox(
                              width: responsive.wp(100),
                              child: ButtonsFunction(),
                            ),
                            Text(
                              message.metadata?['response'].split("~")[1],
                              style: TextStyle(
                                  fontSize: FontSize.body.medium,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    }
                    if (message.metadata?['type'] == 'medicos') {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: responsive.hp(2),
                          horizontal: responsive.wp(3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // // Aquí envolvemos el ListView.builder en un Expanded
                            controller.frecuentMedic.isEmpty
                                ? Column(
                                    children: [
                                      // Text(

                                      SizedBox(
                                        height: responsive.hp(1),
                                        child: ListView.builder(
                                          itemCount:
                                              controller.frecuentMedic.length,
                                          itemBuilder: (context, index) {
                                            final medic =
                                                controller.frecuentMedic[index];
                                            return MedicContainer(medic: medic);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),

                            SizedBox(
                                height: responsive.hp(30),
                                width: responsive.wp(100),
                                child: const DirectorioMedicoScreen())
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink(); // Por defecto
                  },
                  messages: controller.messages.value,
                  onSendPressed: controller.handleSendPressed,
                  user: const types.User(
                      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac'),
                )),
          ),
        ),
      ),
    );
  }
}
