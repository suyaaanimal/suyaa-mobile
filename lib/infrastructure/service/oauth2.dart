import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class Oauth2 {
  final authorizationEndpoint = Uri.parse(
      'https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=238QNP&redirect_uri=https%3A%2F%2Fsuyaa.page.link%2Fauth%2Ffitbit%2Fcallback&scope=sleep&expires_in=28800&prompt=login+consent&code_challenge=1UOp5vhVyWrZgl-vT8L8S5f32T81zT13YvAP2YmFdXY&code_challenge_method=S256');

  final redirectUrl = Uri.parse('https://suyaa.page.link/auth/fitbit/callback');

  Future<void> redirect(Uri authorizationUrl) async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<Uri> listen(Uri redirectUrl) {
    final completer = Completer<Uri>();

    linkStream.listen((event) {
      if ((event?.startsWith(redirectUrl.toString()) ?? false)) {
        completer.complete(Uri.parse(event!));
      }
    });
    return completer.future;
  }

  Future<String> getToken() async {
    await redirect(authorizationEndpoint);
    final uri = await listen(redirectUrl);
    if (!uri.queryParameters.containsKey('code')) {
      throw Exception();
    }
    return uri.queryParameters['code']!;
  }
}
