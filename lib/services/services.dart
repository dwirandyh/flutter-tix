import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireAuth;
import 'package:flutter_tix/models/models.dart';
import 'package:flutter_tix/extensions/extensions.dart';
import 'package:flutter_tix/shared/shared.dart';
import 'package:http/http.dart' as http;

part 'auth_services.dart';
part 'user_services.dart';
part 'movie_services.dart';
part 'ticket_services.dart';
part 'flutix_transaction_services.dart';

class ServiceResult<T> {
  final T data;
  final String message;

  ServiceResult({this.data, this.message});
}
