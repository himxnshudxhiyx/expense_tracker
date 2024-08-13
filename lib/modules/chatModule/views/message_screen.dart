import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Widgets/text_widget.dart';
import 'package:expense_tracker/modules/chatModule/controller/message_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/common_functions.dart';

class MessageScreen extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Obx(
          () => TextView(
            text: '${controller.personName.value}',
            fontColor: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => (controller.chatRoomId.value == '')
            ? Center(
                child: CupertinoActivityIndicator(
                color: Colors.grey.shade500,
                radius: 10,
              ))
            : Column(
                children: [
                  /*Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chatRooms')
                    .doc(controller.chatRoomId.value)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator(color: Colors.grey.shade500, radius: 10,));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: Text('No messages yet.'));
                  }

                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final timestamp =
                          message['timestamp'].toDate();
                      final senderNumber = message['senderNumber'];
                      final receiverNumber = message['receiverNumber'];
                      final msg = message['message'];
                      return Align(
                        alignment: senderNumber == controller.userDetails.value.phoneNumber.toString()
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: (msg.toString().length > 50) ? Get.width * 0.7:null,
                          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                          margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                          decoration: BoxDecoration(
                            color: senderNumber == controller.userDetails.value.phoneNumber.toString()
                                ? Colors.blue[100]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: senderNumber == controller.userDetails.value.phoneNumber.toString()
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: msg,
                                maxLines: 10,
                                fontSize: 16.sp,
                              ),
                              TextView(
                                text: '${convertDateFormat(dateString: timestamp.toLocal().toString(), format: 'hh:mm a')}',
                                fontSize: 12.sp,

                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),*/
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chatRooms')
                          .doc(controller.chatRoomId.value)
                          .collection('messages')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.grey.shade500,
                              radius: 10,
                            ),
                          );
                        }

                        if (!snapshot.hasData) {
                          return Center(child: Text('No messages yet.'));
                        }

                        final messages = snapshot.data!.docs;

                        // Group messages by date
                        final groupedMessages =
                            controller.groupMessagesByDate(messages);

                        return ListView(
                          reverse:
                              true, // No need to reverse the ListView itself
                          children: groupedMessages.entries.map((entry) {
                            final date = entry.key;
                            final messagesForDate = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date Header
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.sp, horizontal: 12.sp),
                                    child: TextView(
                                      text: date, // Format the date as needed
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                // Messages for this date
                                ...messagesForDate
                                    .map((message) {
                                      final timestamp =
                                          message['timestamp'].toDate();
                                      final senderNumber =
                                          message['senderNumber'];
                                      final receiverNumber =
                                          message['receiverNumber'];
                                      final msg = message['message'];

                                      return Align(
                                        alignment: senderNumber ==
                                                controller.userDetails.value
                                                    .phoneNumber
                                                    .toString()
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          width: (msg.toString().length > 50)
                                              ? Get.width * 0.7
                                              : null,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.sp,
                                              vertical: 6.sp),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12.sp,
                                              vertical: 6.sp),
                                          decoration: BoxDecoration(
                                            color: senderNumber ==
                                                    controller.userDetails.value
                                                        .phoneNumber
                                                        .toString()
                                                ? Colors.blue[100]
                                                : Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: senderNumber ==
                                                    controller.userDetails.value
                                                        .phoneNumber
                                                        .toString()
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              TextView(
                                                text: msg,
                                                maxLines: 20,
                                                fontSize: 16.sp,
                                              ),
                                              TextView(
                                                text:
                                                    '${convertDateFormat(dateString: timestamp.toLocal().toString(), format: 'hh:mm a')}',
                                                fontSize: 12.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                    .toList()
                                    .reversed,
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  MessageInput(
                    chatRoomId: controller.chatRoomId.value,
                    userPhoneNumber:
                        controller.userDetails.value.phoneNumber.toString(),
                    receiverNumber: controller.phoneNumber,
                  ),
                ],
              ),
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final String chatRoomId;
  final String userPhoneNumber;
  final String receiverNumber;

  MessageInput(
      {required this.chatRoomId,
      required this.userPhoneNumber,
      required this.receiverNumber});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  final MessageController messageController = Get.find<MessageController>();
  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoomId)
          .collection('messages')
          .add({
        'timestamp': DateTime.now(),
        'senderNumber': widget.userPhoneNumber,
        'receiverNumber':
            widget.receiverNumber, // Replace with actual receiver number
        'message': message,
      });
      _messageController.clear();
      messageController.sendNotification(message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send_rounded),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
