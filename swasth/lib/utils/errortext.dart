import 'package:flutter/material.dart';
import 'package:swasth/utils/enums.dart';
import 'package:swasth/utils/textstyles.dart';

class ErrorText extends StatelessWidget {
  final ErrorCategory errorCategory;

  const ErrorText({Key key, @required this.errorCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;
    String description;

    switch (errorCategory) {
      case ErrorCategory.connectionFailed:
        {
          title = "Failed to connect with server";
          description = "Please check your internet connection and try again";
          break;
        }
      case ErrorCategory.badRequest:
        {
          title = "Unable to process request";
          description = "Please try again later. We're very sorry!";
          break;
        }
      case ErrorCategory.invalidServerResponse:
        {
          title = "Unable to process server response";
          description = "Please try again later. We're very sorry!";
          break;
        }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: regularTextStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: lightTextStyle,
        )
      ],
    );
  }
}
