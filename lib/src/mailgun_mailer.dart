import 'dart:convert';
import 'dart:io';

import 'package:mail/mail.dart';
import 'package:http/http.dart' as http;

class MailgunMailer implements Mailer {
  final String domain;
  final String apiKey;
  final String from;

  MailgunMailer({this.domain, this.apiKey, this.from});

  @override
  Future<SendResponse> send(
      {String from,
      List<String> to = const [],
      List<String> cc = const [],
      List<String> bcc = const [],
      List attachments = const [],
      String subject,
      String html,
      String text}) async {
    var client = http.Client();
    var request = http.Request(
        'POST',
        Uri(
            userInfo: 'api:$apiKey',
            scheme: 'https',
            host: 'api.mailgun.net',
            path: '/v3/$domain/messages'));
    var body = Map<String, String>();
    if (subject != null) {
      body['subject'] = subject;
    }
    if (html != null) {
      body['html'] = html;
    }
    if (text != null) {
      body['text'] = text;
    }
    if (from != null) {
      body['from'] = from;
    }
    if (to.length > 0) {
      body['to'] = to.join(", ");
    }
    if (cc.length > 0) {
      body['cc'] = cc.join(", ");
    }
    if (bcc.length > 0) {
      body['bcc'] = bcc.join(", ");
    }
    request.bodyFields = body;
    try {
      var response = await client.send(request);
      var responseBody = await response.stream.bytesToString();
      var jsonBody = jsonDecode(responseBody);
      var message = jsonBody['message'] ?? '';
      if (response.statusCode != HttpStatus.ok) {
        return SendResponse(status: SendResponseStatus.FAIL, message: message);
      }

      return SendResponse(status: SendResponseStatus.SUCCESS, message: message);
    } catch (e) {
      return SendResponse(
          status: SendResponseStatus.FAIL, message: e.toString());
    } finally {
      client.close();
    }
  }
}
