import 'package:flutter/material.dart';
import 'package:flutter_craft/flavors/build_config.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

mixin BaseWidgetMixin on ConsumerWidget {
  final Logger logger = BuildConfig.instance.config.logger;
  //AppLocalizations appLocalization = AppLocalizations.of(navigatorKey.currentContext!)!;
  AppLocalizations appLocalization(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: body(context, ref),
    );
  }

  Widget body(BuildContext context, WidgetRef ref);
}
