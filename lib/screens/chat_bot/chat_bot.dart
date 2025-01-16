import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

const String giminiApiKey = "AIzaSyBSd-DtFNc9-Mk4jRagSzecsNRvuitvRYQ";

class SkinSafeBot extends StatefulWidget {
  const SkinSafeBot({super.key});

  @override
  State<SkinSafeBot> createState() => _SkinSafeBotState();
}

class _SkinSafeBotState extends State<SkinSafeBot> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textSize20(text: 'Skin Safe Bot'),
        centerTitle: true,
      ),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: sendMediaMessage,
          icon: const Icon(Icons.image),
        ),
      ]),
      currentUser: currentUser,
      onSend: sendMessage,
      messages: messages,
    );
  }

  void sendMessage(ChatMessage chatMsg) {
    setState(() {
      messages = [chatMsg, ...messages];
    });
    try {
      String questions = chatMsg.text;
      List<Uint8List>? images;
      if (chatMsg.medias?.isNotEmpty ?? false) {
        images = [File(chatMsg.medias!.first.url).readAsBytesSync()];
      }
      // ignore: deprecated_member_use
      gemini.streamGenerateContent(questions, images: images).listen(
        (event) {
          ChatMessage? lastMessage = messages.firstOrNull;
          if (lastMessage != null && lastMessage.user == geminiUser) {
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts
                    ?.whereType<TextPart>()
                    .map((part) => part.text)
                    .join("") ??
                "";

            lastMessage.text += response;
            setState(() {
              messages = [lastMessage!, ...messages];
            });
          } else {
            String response = event.content?.parts
                    ?.whereType<TextPart>()
                    .map((part) => part.text)
                    .join("") ??
                "";

            ChatMessage message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );
            setState(() {
              messages = [message, ...messages];
            });
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMsg = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image),
          ]);
      sendMessage(chatMsg);
    }
  }
}
