import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_assesment/app/core/values/app_colors.dart';
import 'package:weather_assesment/flavors/build_config.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseView extends ConsumerStatefulWidget {
  BaseView({super.key});

  @override
  ConsumerState<BaseView> createState() => _BaseViewState();

  // This method must be implemented by subclasses to build the actual view
  Widget body(BuildContext context, WidgetRef ref);

  PreferredSizeWidget? appBar(BuildContext context);

  late AppLocalizations appLocalization;

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar(BuildContext context, WidgetRef ref) {
    return null;
  }

  Widget? drawer(BuildContext context) {
    return null;
  }
}

class _BaseViewState extends ConsumerState<BaseView> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final Logger logger = BuildConfig.instance.config.logger;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    widget.appLocalization = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        child: Stack(
          children: [
            annotatedRegion(context),
          ],
        ),
      ),
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: statusBarColor(),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        color: Colors.transparent,
        child: pageScaffold(context),
      ),
    );
  }

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      //sets ios status bar color
      key: globalKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: widget.appBar(context),
      floatingActionButton: widget.floatingActionButton(),
      body: pageContent(context),
      bottomNavigationBar: widget.bottomNavigationBar(context, ref),
      drawer: widget.drawer(context),
    );
  }

  Widget pageContent(BuildContext context) {
    return SafeArea(
      child: widget.body(context, ref),
    );
  }

  Color statusBarColor() {
    return AppColors.pageBackground;
  }

  Future<bool> onBackPressed() {
    logger.d("On back pressed from base view");

    return Future.value(true);
  }
}
