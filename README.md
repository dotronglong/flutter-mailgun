# flutter-mailgun
Send email through Mailgun API

## Getting Started

- Add dependency

```yaml
dependencies:
  mailgun: ^0.1.0
```

- Initialize mailer instance

```dart
import 'package:mailgun/mailgun.dart';


var mailgun = MailgunMailer(domain: "my-mailgun-domain", apiKey: "my-mailgun-api-key");
```

- Send plain text email

```dart
var response = await mailgun.send(
  from: from,
  to: to,
  subject: "Test email",
  text: "Hello World");
```

- Send HTML email

```dart
var response = await mailgun.send(
  from: from,
  to: to,
  subject: "Test email",
  html: "<strong>Hello World</strong>");
```

- Send email using template and template's variables

```dart
var response = await mailgun.send(
  from: from,
  to: to,
  subject: "Test email",
  template: "my-template",
  options: {
    'template_variables': {
      'author': 'John'
    }
  });
```

- Send email with attachments

```dart
var file = new File('photo.jpg');
var response = await mailgun.send(
  from: from,
  to: to,
  subject: "Test email",
  html: "Please check my <strong>attachment</strong>",
  attachments: [file]);
```

## Response

Below are possible statuses of `response.status`:

- `SendResponseStatus.OK`: mail is sent successfully
- `SendResponseStatus.QUEUED`: mail is added to queue, for example, mailgun is not delivered mail immediately
- `SendResponseStatus.FAIL`: failed to send email

In case of failure, error's message is under `response.message`