import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tix/models/models.dart';
import 'package:flutter_tix/extensions/extensions.dart';

part 'auth_services.dart';
part 'user_services.dart';

class ServiceResult<T> {
  final T data;
  final String message;

  ServiceResult({this.data, this.message});
}
