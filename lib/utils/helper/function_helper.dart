import 'package:carwan_dough/utils/helper/error_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String generateId() => DateTime.now().toIso8601String();

String parseError(Object error) {
  if (error is FirebaseAuthException) {
    return FirebaseAuthErrorMapper.message(error);
  }
  if (error is FirebaseException) {
    return FirestoreErrorMapper.message(error);
  }
  return error.toString();
}

void handleLaunchUrl(String uri) async {
  final Uri url = Uri.parse(uri);
  if (uri.startsWith("mailto:")) {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
    return;
  }

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}

// onTap: () => handleLaunchUrl("https://github.com/AyaAbdElmoneim158?tab=repositories"),
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'confirmed':
      return Colors.green;
    case 'canceled':
      return Colors.red;
    case 'delivered':
      return Colors.blue;
    default:
      return Colors.grey;
  }
}
