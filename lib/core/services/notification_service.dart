import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Service for push notifications
/// Note: Firebase Cloud Messaging will be integrated when Firebase is added
class NotificationService {
  // TODO: Initialize Firebase Messaging when Firebase is integrated
  // final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize notifications
  Future<Either<Failure, void>> initialize() async {
    try {
      // TODO: Request notification permissions
      // final settings = await _messaging.requestPermission(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      // );

      // TODO: Get FCM token
      // final token = await _messaging.getToken();
      // print('FCM Token: $token');

      // TODO: Setup message handlers
      // FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      // FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Get FCM token
  Future<Either<Failure, String>> getToken() async {
    try {
      // TODO: Get FCM token
      // final token = await _messaging.getToken();
      // return Right(token ?? '');

      return const Right('');
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Delete FCM token
  Future<Either<Failure, void>> deleteToken() async {
    try {
      // TODO: Delete FCM token
      // await _messaging.deleteToken();

      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Subscribe to topic
  Future<Either<Failure, void>> subscribeToTopic(String topic) async {
    try {
      // TODO: Subscribe to topic
      // await _messaging.subscribeToTopic(topic);

      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Unsubscribe from topic
  Future<Either<Failure, void>> unsubscribeFromTopic(String topic) async {
    try {
      // TODO: Unsubscribe from topic
      // await _messaging.unsubscribeFromTopic(topic);

      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Handle foreground message
  // void _handleForegroundMessage(RemoteMessage message) {
  //   // Handle foreground notification
  //   print('Foreground message: ${message.notification?.title}');
  // }

  /// Handle background message
  // void _handleBackgroundMessage(RemoteMessage message) {
  //   // Handle background notification tap
  //   print('Background message: ${message.notification?.title}');
  // }
}

