// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//   final bool isRead;
//
//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.message,
//     required this.timestamp,
//     this.isRead = false,
//   });
//
//   factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return ChatMessage(
//       id: doc.id,
//       senderId: data['senderId'] ?? '',
//       receiverId: data['receiverId'] ?? '',
//       message: data['message'] ?? '',
//       timestamp: (data['timestamp'] as Timestamp).toDate(),
//       isRead: data['isRead'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'message': message,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'isRead': isRead,
//     };
//   }
// }
//
// class Doctor {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String specialization;
//   final String imgURL;
//   final bool isAvailable;
//
//   Doctor({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.specialization,
//     required this.imgURL,
//     this.isAvailable = true,
//   });
//
//   factory Doctor.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Doctor(
//       id: doc.id,
//       firstName: data['firstname'] ?? '',
//       lastName: data['lastname'] ?? '',
//       email: data['email'] ?? '',
//       specialization: data['specialization'] ?? '',
//       imgURL: data['profileImage'] ?? '',
//       isAvailable: data['isAvailable'] ?? true,
//     );
//   }
// }
//
// final doctorProvider = FutureProvider<Doctor?>((ref) async {
//   final doctorEmail = 'msabir0018@gmail.com'; // The specific doctor email
//
//   try {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('doctors')
//         .where('email', isEqualTo: doctorEmail)
//         .limit(1)
//         .get();
//
//     if (querySnapshot.docs.isEmpty) {
//       return null;
//     }
//
//     return Doctor.fromFirestore(querySnapshot.docs.first);
//   } catch (e) {
//     print('Error fetching doctor: $e');
//     return null;
//   }
// });
//
// // Provider for chat messages
// final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>((ref, doctorId) {
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   if (userId == null) return Stream.value([]);
//
//   return FirebaseFirestore.instance
//       .collection('chats')
//       .doc('${userId}_$doctorId')
//       .collection('messages')
//       .orderBy('timestamp', descending: true)
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList();
//   });
// });
//
// // Chat controller to send messages
// class ChatController extends StateNotifier<AsyncValue<void>> {
//   ChatController() : super(const AsyncValue.data(null));
//
//   Future<void> sendMessage({
//     required String message,
//     required String receiverId,
//     required String chatId,
//   }) async {
//     state = const AsyncValue.loading();
//     try {
//       final userId = FirebaseAuth.instance.currentUser?.uid;
//       if (userId == null) throw Exception('User not authenticated');
//
//       final newMessage = ChatMessage(
//         id: '', // Firestore will generate this
//         senderId: userId,
//         receiverId: receiverId,
//         message: message,
//         timestamp: DateTime.now(),
//       );
//
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .add(newMessage.toMap());
//
//       state = const AsyncValue.data(null);
//     } catch (error, stackTrace) {
//       state = AsyncValue.error(error, stackTrace);
//     }
//   }
//
//   Future<void> markAsRead(String messageId, String chatId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .doc(messageId)
//           .update({'isRead': true});
//     } catch (e) {
//       print('Error marking message as read: $e');
//     }
//   }
// }
//
// final chatControllerProvider = StateNotifierProvider<ChatController, AsyncValue<void>>((ref) {
//   return ChatController();
// });
//
// // Register Doctor Function - Call this once to register the doctor
// Future<void> registerDoctor() async {
//   const email = 'msabir0018@gmail.com';
//
//   try {
//     // Check if doctor already exists
//     final existingDoc = await FirebaseFirestore.instance
//         .collection('doctors')
//         .where('email', isEqualTo: email)
//         .get();
//
//     if (existingDoc.docs.isNotEmpty) {
//       print('Doctor already registered');
//       return;
//     }
//
//     // Create auth account for doctor if needed
//     UserCredential? userCredential;
//     try {
//       // You would typically use a secure password and not hardcode it
//       userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: 'securePassword123!', // In production, use a secure method
//       );
//     } catch (e) {
//       print('Auth account may already exist: $e');
//       // Try to sign in to get the user ID
//       userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: 'securePassword123!',
//       );
//     }
//
//     final doctorId = userCredential.user!.uid;
//
//     // Add doctor to Firestore
//     await FirebaseFirestore.instance.collection('doctors').doc(doctorId).set({
//       'firstname': 'Dr. Muhammad',
//       'lastname': 'Sabir',
//       'email': email,
//       'specialization': 'General Physician',
//       'profileImage': '',
//       'isAvailable': true,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//
//     print('Doctor registered successfully with ID: $doctorId');
//
//     // Sign out from doctor account if you were using a different account before
//     await FirebaseAuth.instance.signOut();
//   } catch (e) {
//     print('Error registering doctor: $e');
//   }
// }
//
// class ChatWithDoctorScreen extends ConsumerStatefulWidget {
//   const ChatWithDoctorScreen({Key? key}) : super(key: key);
//
//   @override
//   _ChatWithDoctorScreenState createState() => _ChatWithDoctorScreenState();
// }
//
// class _ChatWithDoctorScreenState extends ConsumerState<ChatWithDoctorScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   Doctor? doctor;
//   String? chatId;
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final doctorAsyncValue = ref.watch(doctorProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: doctorAsyncValue.when(
//           data: (doctor) => doctor != null
//               ? Text('Dr. ${doctor.firstName} ${doctor.lastName}')
//               : const Text('Chat with Doctor'),
//           loading: () => const Text('Loading...'),
//           error: (_, __) => const Text('Error Loading Doctor'),
//         ),
//       ),
//       body: doctorAsyncValue.when(
//         data: (fetchedDoctor) {
//           if (fetchedDoctor == null) {
//             return const Center(
//               child: Text('Doctor not found. Please contact support.'),
//             );
//           }
//
//           doctor = fetchedDoctor;
//           final userId = FirebaseAuth.instance.currentUser?.uid;
//           if (userId == null) {
//             return const Center(
//               child: Text('Please sign in to chat with the doctor'),
//             );
//           }
//
//           chatId = '${userId}_${doctor!.id}';
//           final messagesStream = ref.watch(chatMessagesProvider(doctor!.id));
//
//           return Column(
//             children: [
//               // Doctor info card
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 color: Colors.blue.shade50,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: doctor!.imgURL.isNotEmpty
//                           ? NetworkImage(doctor!.imgURL)
//                           : null,
//                       child: doctor!.imgURL.isEmpty
//                           ? Text(doctor!.firstName[0] + doctor!.lastName[0])
//                           : null,
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Dr. ${doctor!.firstName} ${doctor!.lastName}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           Text(doctor!.specialization),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 10,
//                                 height: 10,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: doctor!.isAvailable ? Colors.green : Colors.red,
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 doctor!.isAvailable ? 'Available' : 'Unavailable',
//                                 style: TextStyle(
//                                   color: doctor!.isAvailable ? Colors.green : Colors.red,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Messages list
//               Expanded(
//                 child: messagesStream.when(
//                   data: (messages) {
//                     if (messages.isEmpty) {
//                       return const Center(
//                         child: Text('No messages yet. Start the conversation!'),
//                       );
//                     }
//
//                     return ListView.builder(
//                       reverse: true,
//                       itemCount: messages.length,
//                       padding: const EdgeInsets.all(16),
//                       itemBuilder: (context, index) {
//                         final message = messages[index];
//                         final isMe = message.senderId == userId;
//
//                         if (!isMe && !message.isRead) {
//                           ref.read(chatControllerProvider.notifier)
//                               .markAsRead(message.id, chatId!);
//                         }
//
//                         return Align(
//                           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 16),
//                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(message.message),
//                                 const SizedBox(height: 4),
//                                 // Text(
//                                 //   '${DateFormat.jm().format(message.timestamp)} · ${isMe && message.isRead ? 'Read' : ''}',
//                                 //   style: TextStyle(
//                                 //     color: Colors.grey.shade700,
//                                 //     fontSize: 10,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   loading: () => const Center(child: CircularProgressIndicator()),
//                   error: (_, __) => const Center(
//                     child: Text('Error loading messages. Please try again later.'),
//                   ),
//                 ),
//               ),
//
//               // Message input
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       blurRadius: 5,
//                       offset: const Offset(0, -1),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _messageController,
//                         decoration: const InputDecoration(
//                           hintText: 'Type your message...',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Consumer(
//                       builder: (context, ref, _) {
//                         final chatState = ref.watch(chatControllerProvider);
//
//                         return IconButton(
//                           onPressed: chatState.isLoading
//                               ? null
//                               : () {
//                             if (_messageController.text.trim().isNotEmpty) {
//                               ref.read(chatControllerProvider.notifier).sendMessage(
//                                 message: _messageController.text.trim(),
//                                 receiverId: doctor!.id,
//                                 chatId: chatId!,
//                               );
//                               _messageController.clear();
//                             }
//                           },
//                           icon: chatState.isLoading
//                               ? const SizedBox(
//                             width: 24,
//                             height: 24,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                               : const Icon(Icons.send, color: Colors.blue),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(
//           child: Text('Error: ${error.toString()}'),
//         ),
//       ),
//     );
//   }
// }