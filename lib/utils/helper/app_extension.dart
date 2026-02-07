import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';

extension NavigationExtension on material.BuildContext {
  Future<T?> push<T>(material.Widget page) {
    return material.Navigator.push<T>(
      this,
      material.MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushReplacement<T, TO>(material.Widget page) {
    return material.Navigator.pushReplacement<T, TO>(
      this,
      material.MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push and remove all previous routes using a Widget
  Future<T?> pushAndRemoveAll<T>(material.Widget page) {
    return material.Navigator.pushAndRemoveUntil<T>(
      this,
      material.MaterialPageRoute(builder: (_) => page),
      (_) => false,
    );
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    material.Navigator.pop(this, result);
  }

  /// Push a named route
  Future<T?> pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return material.Navigator.pushNamed<T>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Replace current route with named route
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return material.Navigator.pushReplacementNamed<T, TO>(
      this,
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Push a named route and remove all previous routes
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    material.RoutePredicate predicate, {
    Object? arguments,
  }) {
    return material.Navigator.pushNamedAndRemoveUntil<T>(
      this,
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushWithAnimation<T>(
    material.Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    material.Curve curve = material.Curves.easeInOut,
  }) {
    return material.Navigator.push<T>(
      this,
      material.PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation = animation.drive(
            material.Tween(begin: const material.Offset(1.0, 0.0), end: material.Offset.zero).chain(material.CurveTween(curve: curve)),
          );
          return material.SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  Future<T?> pushReplacementWithAnimation<T, TO>(
    material.Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    material.Curve curve = material.Curves.easeInOut,
  }) {
    return material.Navigator.pushReplacement<T, TO>(
      this,
      material.PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation = animation.drive(
            material.Tween(begin: const material.Offset(1.0, 0.0), end: material.Offset.zero).chain(material.CurveTween(curve: curve)),
          );
          return material.SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: duration,
      ),
    );
  }

  Future<T?> pushAndRemoveAllWithAnimation<T>(
    material.Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    material.Curve curve = material.Curves.easeInOut,
  }) {
    return material.Navigator.pushAndRemoveUntil<T>(
      this,
      material.PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation = animation.drive(
            material.Tween(begin: const material.Offset(1.0, 0.0), end: material.Offset.zero).chain(material.CurveTween(curve: curve)),
          );
          return material.SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: duration,
      ),
      (_) => false,
    );
  }
}

extension ShimmerExtension on Widget {
  Widget withShimmer({
    bool isShow = true,
    Color? color,
    Key? key,
  }) {
    return _ShimmerWrapper(
      key: key,
      isShow: isShow,
      color: color,
      child: this,
    );
  }
}

class _ShimmerWrapper extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final Color? color;

  const _ShimmerWrapper({
    super.key,
    required this.child,
    required this.isShow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShow) return child;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
      highlightColor: Theme.of(context).colorScheme.onSurface.withOpacity(.1),
      child: Container(
        color: color ?? Theme.of(context).colorScheme.surface,
        child: child,
      ),
    );
  }
}

extension PopupExtension on BuildContext {
  // Success Dialog
  Future<void> showSuccessDialog({
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.check_circle,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  // Error Dialog
  Future<void> showErrorDialog({
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
  }) {
    return showDialog<void>(
      context: this,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  // Loading Dialog (improved)
  Future<void> showLoadingDialog({
    String message = 'Loading...',
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  // Confirmation Dialog (improved)
  Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool dangerousAction = false,
  }) async {
    return await showDialog<bool>(
          context: this,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  confirmText,
                  style: dangerousAction ? TextStyle(color: Theme.of(context).colorScheme.error) : null,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Existing methods with minor improvements...

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Theme.of(this).colorScheme.errorContainer : null,
        action: action,
      ),
    );
  }
}

extension MediaQueryValues on BuildContext {
  /// Screen width
  double get width => MediaQuery.of(this).size.width;

  /// Screen height
  double get height => MediaQuery.of(this).size.height;

  /// Text scale factor from device settings
  double get textScale => MediaQuery.of(this).textScaleFactor;

  /// Safe area paddings (top, bottom, etc.)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Height excluding safe area (status bar & nav bar)
  double get safeHeight => height - padding.top - padding.bottom;

  /// Reference design size
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  /// Scale size horizontally based on design width
  double scaleWidth(double size) => (width / _designWidth) * size;

  /// Scale size vertically based on design height
  double scaleHeight(double size) => (height / _designHeight) * size;

  /// Scale font with respect to screen width and text scale
  double scaleFont(double size) {
    final scaledSize = (width / _designWidth) * size;
    return scaledSize * textScale;
  }

  /// Scale radius based on design width
  double scaleRadius(double size) => scaleWidth(size);

  /// Smart scale: uses the smaller ratio between width and height
  double scaleSmart(double size) {
    final widthRatio = width / _designWidth;
    final heightRatio = height / _designHeight;
    return size * (widthRatio < heightRatio ? widthRatio : heightRatio);
  }
}

extension AppDecorations on BoxDecoration {
  static BoxDecoration get bottomNavigationBar => BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xB2B2CCFF), // #B2CCFFB2
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x80B2CCFF), // #B2CCFF80
            offset: Offset(0, -1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      );
}

extension AnimateDoExt2 on Widget {
  // Fades
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      FadeIn(duration: duration, delay: delay, child: this);

  Widget fadeInDown({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      FadeInDown(duration: duration, delay: delay, child: this);

  Widget fadeInUp({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      FadeInUp(duration: duration, delay: delay, child: this);

  Widget fadeInLeft({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      FadeInLeft(duration: duration, delay: delay, child: this);

  Widget fadeInRight({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      FadeInRight(duration: duration, delay: delay, child: this);

  // Bounces
  Widget bounceIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      BounceIn(duration: duration, delay: delay, child: this);

  Widget bounceInDown({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      BounceInDown(duration: duration, delay: delay, child: this);

  Widget bounceInUp({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      BounceInUp(duration: duration, delay: delay, child: this);

  Widget bounceInLeft({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      BounceInLeft(duration: duration, delay: delay, child: this);

  Widget bounceInRight({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      BounceInRight(duration: duration, delay: delay, child: this);

  // Slides
  Widget slideInUp({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      SlideInUp(duration: duration, delay: delay, child: this);

  Widget slideInDown({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      SlideInDown(duration: duration, delay: delay, child: this);

  Widget slideInLeft({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      SlideInLeft(duration: duration, delay: delay, child: this);

  Widget slideInRight({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      SlideInRight(duration: duration, delay: delay, child: this);

  // Zooms
  Widget zoomIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      ZoomIn(duration: duration, delay: delay, child: this);

  Widget zoomInDown({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      ZoomInDown(duration: duration, delay: delay, child: this);

  // Widget zoomInUp({
  //   Duration duration = const Duration(milliseconds: 600),
  //   Duration delay = Duration.zero,
  // }) =>
  //     ZoomInUp(duration: duration, delay: delay, child: this);

  // Widget zoomInLeft({
  //   Duration duration = const Duration(milliseconds: 600),
  //   Duration delay = Duration.zero,
  // }) =>
  //     ZoomInLeft(duration: duration, delay: delay, child: this);

  // Widget zoomInRight({
  //   Duration duration = const Duration(milliseconds: 600),
  //   Duration delay = Duration.zero,
  // }) =>
  //     ZoomInRight(duration: duration, delay: delay, child: this);

  // Special
  Widget elasticIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      ElasticIn(duration: duration, delay: delay, child: this);

  Widget jelloIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      JelloIn(duration: duration, delay: delay, child: this);

  Widget flash({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      Flash(duration: duration, delay: delay, child: this);

  Widget pulse({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      Pulse(duration: duration, delay: delay, child: this);

  Widget swing({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      Swing(duration: duration, delay: delay, child: this);

  Widget tada({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      Tada(duration: duration, delay: delay, child: this);

  Widget wobble({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) =>
      Wobble(duration: duration, delay: delay, child: this);
}
