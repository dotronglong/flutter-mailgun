import 'package:flutter_test/flutter_test.dart';
import 'package:mail/mail.dart';
import 'package:mailgun/mailgun.dart';

void main() {
  test('send email success', () async {
    final mailer = MailgunMailer(
        domain: 'sandbox33315.mailgun.org',
        apiKey: 'key-cf4c8800906cd84d0a7db16dbfbb186e');
    var response = await mailer.send(
        from: 'me@dotronglong.com',
        to: ['mailgun-6789@yopmail.com'],
        subject: 'Hello World',
        text: 'This is a text message');
    expect(response.status, SendResponseStatus.SUCCESS);
  });

  test('send email fail', () async {
    final mailer = MailgunMailer(
        domain: 'sandbox33315.mailgun.org',
        apiKey: 'key-invalid');
    var response = await mailer.send(
        from: 'me@dotronglong.com',
        to: ['mailgun-6789@yopmail.com'],
        subject: 'Hello World',
        text: 'This is a text message');
    expect(response.status, SendResponseStatus.FAIL);
  });
}
